class Label < ApplicationRecord
  belongs_to :user

  validates :user,   presence: true, uniqueness: { scope: [:name, :colour] }
  validates :name,   presence: true
  validates :colour, presence: true
end
