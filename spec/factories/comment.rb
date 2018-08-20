# frozen_string_literal: true

FactoryBot.define do
    factory :comment do
        article
        commenter { Faker::Comment.commenter }
        body  { Faker::Comment.body }
    end
end
  