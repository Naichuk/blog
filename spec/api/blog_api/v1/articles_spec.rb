# frozen_string_literal: true

require 'rails_helper'

describe 'V1::Articles' do

  describe 'GET /api/v1/articles' do
    let(:art_1) { Article.create({title: 'Hello', text: 'LKJLJOIJ'})}
    let(:do_request) { get '/api/v1/articles' }
    let(:expected_response) { Article.all.to_json }

    it 'returns all articles' do
      do_request
      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_response)
    end
  end

  describe 'GET /api/v1/articles/:article_id' do
    let(:art_1) { Article.create({title: 'Hello1', text: 'LKJLJOIJ1'})}
    #let(:art_2) { Article.create({title: 'Hello2', text: 'LKJLJOIJ2'})}
    #let(:art_3) { Article.create({title: 'Hello3', text: 'LKJLJOI3'})}
    #let(:art_4) { Article.create({title: 'Hello4', text: 'LKJLJOIJ4'})}
    let(:do_true_request) {get "/api/v1/articles/#{art_1.id}"}
    #let(:do_false_request) {get "/api/v1/articles/1000"}
    let(:expected_response) { art_1.to_json }
    #let(:expected_response_for_not_found) do
    #  { error: 'Article not found' }.to_json
    #end

    it 'return specific article' do
      do_true_request
      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_response)
    end

    #it 'return error when article not found' do
    #  do_false_request

    #  expect(response.status).to eq(404)
    #  expect(response.body).to eq(expected_response_for_not_found)
    #end
  end

  describe 'POST /api/v1/articles' do
    let(:body) do { title: 'booms', text: 'black' } end
    let(:do_request) { post '/api/v1/articles', params: body }

    it 'create article' do
      do_request
      expect(response.status).to eq(201)
    end
  end

  describe 'DELETE /api/v1/articles/:article_id' do
    let(:art_1) { Article.create({title: 'Hello1', text: 'LKJLJOIJ1'})}
    let(:do_request) {delete "/api/v1/articles/#{art_1.id}"}

    it 'return delete response' do
      do_request
      expect(response.status).to eq(204)
      expect(Article.count).to eq(0)
    end
  end

  describe 'PUT /api/v1/articles/:article_id' do
    let(:art_1) { Article.create({title: 'Hello1', text: 'LKJLJOIJ1'})}
    let(:body) do { title: 'booms', text: 'black' } end
    let(:do_request) { put "/api/v1/articles/#{art_1.id}", params: body }
    #let(:expected_response) { .to_json}
    it 'update put response' do
      do_request

      expect(response.status).to eq(200)
      expect(response.body).to eq(Article.first.to_json)
    end
  end
end