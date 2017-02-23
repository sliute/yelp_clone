require 'rails_helper'

describe Review, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:restaurant) }
  end

  it 'is invalid if the raiting is more than 5' do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end
end
