module Api
  module V1
      class AuthorsController < ApplicationController

        def index
          @authors = Author.all
        end

        def create
          author = Author.new(author_params)
          if author.save
            render json: author
          else
            render json: author.errors, status: :bad_request
          end

        end

        private
        attr_reader :authors

        def author_params
          params.require(:author).permit(:first_name, :last_name, :age)
        end
  end
  end
end