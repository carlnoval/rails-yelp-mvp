class Restaurant < ApplicationRecord
  # A restaurant must have a name, an address and a category.
  # A restaurant’s category must belong to this fixed list: ["chinese", "italian", "japanese", "french", "belgian"].
  # When a restaurant is destroyed, all of its reviews must be destroyed as well.

  # rails g model Restaurant name address phone_number category

  # deleting a restaurant will also delete all reviews related to it
  has_many :reviews, dependent: :destroy

  # presence validation
  validates :name, :address, :phone_number, presence: :true
  validates :category, inclusion: { in: %w[chinese italian japanese french belgian], message: "must be one of: Chinese, Italian, Japanese, French, Belgian" }
  validates :phone_number, format: { with: /\A^[-\(\)\d\.\ ]+\z/, message: "only allows numbers and these characters: ()-. and space" }

  def em
    self.save
    self.errors.messages
  end
end
