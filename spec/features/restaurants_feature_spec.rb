require 'rails_helper'

feature 'restaurants' do

  before do
    @user = User.create(email: 'test@test.com', password: 'test123')
    @restaurant = Restaurant.create(name: 'KFC', user: @user)
    signup_and_in
  end

  context 'restaurants have been added' do
    before do
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
       save_and_open_page
       click_link 'KFC'
       expect(page).to have_content 'KFC'
       expect(current_path).to eq "/restaurants/#{@restaurant.id}"
      end
    end

  context 'editing restaurants' do
    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'Deep fried goodness'
      click_button 'Update Restaurant'
      click_link 'Kentucky Fried Chicken'
      expect(page).to have_content('Kentucky Fried Chicken')
      expect(page).to have_content('Deep fried goodness')
      expect(current_path).to eq('/restaurants/1')
    end
  end

  context 'deleting a restaurant' do
    before { Restaurant.create name: 'KFC', description: 'Deep fried goodness', id:1 }

    scenario 'removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end
end
