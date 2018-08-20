# frozen_string_literal: true

FactoryBot.define do
    factory :article do
        title { Faker::Article.title }
        text  { Faker::Article.text }
    end
end
  