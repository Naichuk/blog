# frozen_string_literal: true

  class Base < Grape::API
    format :json
    mount V1::Articles
    mount V1::Comments
  end
