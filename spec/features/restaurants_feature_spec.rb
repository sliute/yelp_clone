require 'rails_helper'

feature 'restaurants' do

  before do
    @user = User.create(email: 'test@test.com', password: 'test123')
    @restaurant = Restaurant.create(name: 'KFC', user: @user)
  end

  context 'restaurants have been added' do
    before do
      signup_and_in
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

    context 'creating restaurants' do
        scenario 'prompts user to fill out a form, then displays new restaurant' do
          visit '/restaurants'
          expect(current_path).to eq '/restaurants'
        end
        context 'an invalid restaurant' do
        scenario 'does not let you submit a name that is too short' do
          signup_and_in
          visit '/restaurants'
          click_link 'Add a restaurant'
          fill_in 'Name', with: 'kf'
          click_button 'Create Restaurant'
          expect(page).not_to have_css 'h2', text: 'kf'
          expect(page).to have_content 'error'
        end
      end
    end

    context 'viewing restaurants' do

      scenario 'lets a user view a restaurant' do
       visit '/restaurants'
       click_link 'KFC'
       expect(page).to have_content 'KFC'
       expect(current_path).to eq "/restaurants/#{@restaurant.id}"
      end
    end

  context 'editing restaurants' do

    before do
      @user = User.create(email: 'ben@ben.com', password: 'ben123')
      @restaurant = Restaurant.create(name: 'KFC2', user: @user)
    end

    scenario 'let a user edit a restaurant' do
      visit('/')
      click_link('Sign in')
      fill_in('Email', with: 'ben@ben.com')
      fill_in('Password', with: 'ben123')
      click_button('Log in')
      # visit '/restaurants'
      click_link 'Edit KFC2'
      fill_in 'Name', with: 'Kentucky Fried Chicken 2'
      fill_in 'Description', with: 'Deep fried goodness'
      click_button 'Update Restaurant'
      click_link 'Kentucky Fried Chicken 2'
      expect(page).to have_content('Kentucky Fried Chicken 2')
      expect(page).to have_content('Deep fried goodness')
      expect(current_path).to eq "/restaurants/#{@restaurant.id}"
    end
  end

  context 'deleting a restaurant' do
    before do
      @user = User.create(email: 'ben@ben.com', password: 'ben123')
      @restaurant = Restaurant.create(name: 'KFC2', user: @user)
    end

    scenario 'removes a restaurant when a user clicks a delete link' do
      visit('/')
      click_link('Sign in')
      fill_in('Email', with: 'ben@ben.com')
      fill_in('Password', with: 'ben123')
      click_button('Log in')
      visit '/restaurants'
      click_link 'Delete KFC2'
      expect(page).not_to have_content 'KFC2'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end
end
