class Review < ApplicationRecord
  # A review must belong to a restaurant.
  # A review must have content and a rating.
  # A review’s rating must be a number between 0 and 5.

  # rails g model Review rating:integer content:text restaurant:references

  belongs_to :restaurant

  # inclusion is to make sure that the rating is saved as within 0 to 5 but does not take strings into account...
  # that is where numericality comes to play
  validates :rating, presence: true, inclusion: { in: (0..5), message: "rating must be from 0 to 5 only" }, numericality: { only_integer: true }
  validates :content, presence: true,  length: { minimum: 20, message: "must at least be 20 characters" }

  def em
    self.save
    self.errors.messages
  end
end
