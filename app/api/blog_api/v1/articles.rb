# frozen_string_literal: true

module V1
  class Articles < Grape::API
    version 'v1', using: :path
    prefix :api

    resource :articles do
      desc 'Return list of articles'
      get do
        articles = Article.all
        present articles, with: Entities::Article
      end

      desc 'Return specific article'
      route_param :article_id do
        get do
          article = Article.find(params[:article_id])
          present article, with: Entities::Article
        end
      end

      desc 'Delete specific article'
      route_param :article_id do
        delete do
          article = Article.find(params[:article_id])
          article.destroy
          status 204
        end
      end

      desc 'Update specific article'
      params do
        requires :article_id, type: Integer
        requires :title, type: String, regexp: /\A[\sA-Za-z0-9-]+\z/
        requires :text, type: String
      end
      put '/:article_id' do
          article = Article.find(params[:article_id])
          article.update!({title:params[:title], text:params[:text]})
          present article, with: Entities::Article
      end

      desc 'Create article'
      params do
        requires :title, type: String, regexp: /\A[\sA-Za-z0-9-]+\z/
        requires :text, type: String
      end
      post do
        Article.create({title:params[:title], text:params[:text]})
      end
    end
  end
end
