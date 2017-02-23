require 'rails_helper'

describe Restaurant, type: :model do

  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
  end

  before do
  end
  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it "is not valid unless it has a unique name" do
    @user = User.create(email: 'ben@ben.com', password: 'ben123')
    @restaurant = Restaurant.create(name: "Moe's Tavern", user: @user)
    restaurant = Restaurant.new(name: "Moe's Tavern")
    expect(restaurant).to have(1).error_on(:name)
  end


end
