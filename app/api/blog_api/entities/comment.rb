# frozen_string_literal: true
module BlogApi
  module Entities
    class Comment < Grape::Entity
      format_with(:iso_timestamp) { |d| d.utc }
      expose :id
      expose :commenter
      expose :body
      expose :article_id
      with_options(format_with: :iso_timestamp) do
        expose :created_at
        expose :updated_at
      end
    end
  end
end