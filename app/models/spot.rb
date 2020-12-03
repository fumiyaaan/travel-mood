class Spot < ApplicationRecord
  with_options presence: true do
    validates :image
    validates :title
    validates :description
  end

  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy

  # スポット検索に関するメソッド
  def self.search(search)
    if search != ''
      Spot.where('title LIKE(?)', "%#{search}%")
    else
      Spot.all
    end
  end
end
