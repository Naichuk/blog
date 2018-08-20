# frozen_string_literal: true
module BlogApi
  module V1
    class Articles < Grape::API

      resource :articles do
        desc 'Return list of articles'
        get do
          articles = Article.all
          present articles, with: Entities::Article
        end

        desc 'Return specific article'
        params do
          requires :id, type: Integer
        end
          get '/:id' do
            article = Article.find(params[:id])
            present article, with: Entities::Article
          end

        desc 'Delete specific article'
        params do
          requires :id, type: Integer
        end
        delete '/:id' do
            article = Article.find(params[:id])
            article.destroy
            status 204
        end

        desc 'Update specific article'
        params do
          requires :id, type: Integer
          requires :title, type: String, regexp: /\A[\sA-Za-z0-9-]+\z/
          requires :text, type: String
        end
        put '/:id' do
            article = Article.find(params[:id])
            unless article.update(params)
              error!(article.errors.full_messages.to_sentence, 422)
            end
            present article, with: Entities::Article
        end

        desc 'Create article'
        params do
          requires :title, type: String, regexp: /\A[\sA-Za-z0-9-]+\z/
          requires :text, type: String
        end
        post do
          article = Article.create({title:params[:title], text:params[:text]})
          if article.errors.any?
            error!(article.errors.full_messages.to_sentence, 422)
          end
        end
      end
    end
  end
end
