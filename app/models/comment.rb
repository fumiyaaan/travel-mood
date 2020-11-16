class Comment < ApplicationRecord
  validates :text, presence: true

  UNKNOWN_REGEX = /\A[1-5]\z/
  validates :unknown, presence: true
  validates_format_of :unknown, with: UNKNOWN_REGEX, message: 'Input one number within 1 to 5'

  belongs_to :user
  belongs_to :spot
endails
