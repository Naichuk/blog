class Comment < ApplicationRecord
  belongs_to :article
  validates :commenter, presence: true,
            length: 5..20,
            format: {
                with: /\A[\sA-Za-z0-9]+\z/,
                message: "only allows letters, numbers"
            }
  validates :body, presence: true,
            length: 1..255
end
