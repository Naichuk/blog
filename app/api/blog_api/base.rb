# frozen_string_literal: true
module BlogApi
  class Base < Grape::API
    mount BlogApi::V1::Base
  end
end
