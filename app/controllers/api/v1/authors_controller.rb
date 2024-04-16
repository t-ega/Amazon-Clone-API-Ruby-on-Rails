module Api
  module V1
      class AuthorsController < ApplicationController

        def index
          @authors = Author.all
        end

        def create
          author = Author.new(author_params)
          if author.save
            success_handler({author: author}, :created)
          else
            raise ApplicationError::BadRequest(author.errors.as_json)
          end

        end

        private
        attr_reader :authors

        def author_params
          params.require(:author).permit(:first_name, :last_name, :age, :user_id)
        end
  end
  end
end