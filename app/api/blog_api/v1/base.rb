# frozen_string_literal: true

module BlogApi
  module V1
    class Base < Grape::API
      version 'v1', using: :path
      prefix :api
      format :json
      mount BlogApi::V1::Articles
      mount BlogApi::V1::Comments
    end
  end
end