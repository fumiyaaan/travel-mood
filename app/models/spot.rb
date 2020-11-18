class Spot < ApplicationRecord
  with_options presence: true do
    validates :image
    validates :title
    validates :description
  end

  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
end
