# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe Article, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:text) }

  it { should validate_uniqueness_of(:title) }
  it { should have_many(:comments).dependent(:destroy) }

  context 'Articles with 2 or more comments' do
    it do
      article = Article.create!(title: 'My first tittle', text: 'Bla Bla Bla ')
      expect(Article.count).to eq 1
      comment1 = article.comments.create!(commenter: 'Maksimka', body: 'Gav GAv GAv')
      comment2 = article.comments.create!(commenter: 'Nadinka', body: 'Myr myr myr')
      expect(article.reload.comments).to eq([comment1, comment2])
    end
    after(:all) { Article.destroy_all }
  end

end