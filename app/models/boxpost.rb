class Boxpost < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, numericality: true
end
