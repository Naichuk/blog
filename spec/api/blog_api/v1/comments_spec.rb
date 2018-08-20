# frozen_string_literal: true

require 'rails_helper'

describe 'V1::Comments' do
  let(:art_1) { FactoryBot.create(:article, title: 'asdasdasdaas', text: 'asdasdasdasdasd')}
  let(:comment_1) { FactoryBot.create( :comment, article_id: art_1.id, commenter: 'Nadine', body: 'asdasdasdasd')}
  let(:comment_2) { FactoryBot.create( :comment, article_id: art_1.id ,commenter: 'Nadine1', body: 'asdasdasdasd2')}

  describe 'GET /api/v1/articles/:article_id/comments' do

    let(:do_request) { get "/api/v1/articles/#{art_1.id}/comments" }

    it 'return all comments' do
      do_request

      expect(response.status).to eq(200)
      expect(response.body).to eq(art_1.comments.all.to_json)
    end
  end

  describe 'GET /api/v1/articles/:article_id/comments/:comment_id' do

    let(:do_request) { get "/api/v1/articles/#{art_1.id}/comments/#{comment_1.id}" }

    it 'return specific comments' do
      do_request

      expect(response.status).to eq(200)
      expect(response.body).to eq(art_1.comments.find_by_id(comment_1.id).to_json)
    end
  end

  describe 'POST /api/v1/articles/:article_id/comments' do
    let(:body) do { commenter: 'booms', body: 'black' } end
    let(:do_request) { post "/api/v1/articles/#{art_1.id}/comments", params: body }

    it 'create comment' do
      do_request
      expect(response.status).to eq(201)
    end
  end

  describe 'DELETE /api/v1/articles/:article_id/comments/:comment_id' do
    let(:do_request) {delete "/api/v1/articles/#{art_1.id}/comments/#{comment_1.id}"}

    it 'return delete response' do
      do_request
      expect(response.status).to eq(204)
    end
  end
end
