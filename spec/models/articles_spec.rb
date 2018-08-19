# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe Article, type: :model do
  it { should validate_presence_of(:title) }
end