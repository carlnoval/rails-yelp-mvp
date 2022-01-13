class Review < ApplicationRecord
  # A review must belong to a restaurant.
  # A review must have content and a rating.
  # A review’s rating must be a number between 0 and 5.

  # rails g model Review rating:integer content:text restaurant:references

  belongs_to :restaurant

  # inclusion is to make sure that the rating is saved as within 0 to 5 but does not take strings into account...
  # that is where numericality comes to play
  # possibilities to bump into a scenario where rating of  "five" gets turned to 0 when creating new instance...
  # but "5" is allowed, SO: https://stackoverflow.com/questions/44514099/sqlite-insert-as-integer-and-as-text
  validates :rating, presence: true, inclusion: { in: (0..5), message: "rating must be from 0 to 5 only" }, numericality: { only_integer: true }
  validates :content, presence: true

  def em
    self.save
    self.errors.messages
  end

  def print_stars
    self.rating.zero? ? '<p>Zeero Stars <i class="far fa-frown"></i></p>'.html_safe : ('<i class="fas fa-star"></i>' * self.rating).html_safe
  end
end
