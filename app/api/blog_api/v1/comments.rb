# frozen_string_literal: true

module V1
  class Comments < Grape::API
    version 'v1', using: :path
    prefix :api

    namespace 'articles/:article_id' do
      desc 'Return all comments in specific article'
      get '/comments' do
        comments = Article.find(params[:article_id]).comments
        present comments, with: Entities::Comment
      end

      resources :comments do
        desc 'Return specific comment in specific article'
        route_param :comment_id do
          get do
            comment = Article.find(params[:article_id]).comments.find(params[:comment_id])
            present comment, with: Entities::Comment
           end
        end

        desc 'Delete comment in specific article'
        route_param :comment_id do
          delete do
            comment = Article.find(params[:article_id]).comments.find(params[:comment_id])
            comment.destroy
            status 204
          end
        end

        desc 'Create comment in specific article'
        params do
          requires :commenter, type: String
          requires :body, type: String
        end
        post do
          Article.find(params[:article_id]).comments.create({commenter:params[:commenter], body:params[:body]})
        end
      end
    end
  end
end