class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, presence: true,
            length: 5..50,
            uniqueness: true,
            format: {
                with: /\A[\sA-Za-z0-9-]+\z/,
                message: "only allows letters, numbers, and '-'"
            }
  validates :text, presence: true,
            length: 10..1000

end
