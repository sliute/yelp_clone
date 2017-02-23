require 'rails_helper'

feature 'reviewing' do
  before do
    @user = User.create(email: 'ben@ben.com', password: 'ben123')
    @restaurant = Restaurant.create(name: 'KFC2', user: @user)
  end

  scenario 'allows users to leave a review using a form' do
    signup_and_in
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq('/restaurants')
    expect(page).to have_content('so so')
  end
end
