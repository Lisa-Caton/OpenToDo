class List < ApplicationRecord
  belongs_to :user
  has_many :items

  validates :user, presence: true
  validates :name, length: {minimum: 3}, presence: true
  private
end
