module Api
  module V1

    class BooksController < ApplicationController
      # authenticate is the method we define in concerns/authentication.rb to check request.headers['token']
      before_action :authenticate

      MAX_PAGINATION_LIMIT = 100

      def show
        book = Book.find(params[:id])
        render json: book, serializer: BookSerializer
      end

      def index
        books = Book.limit(limit).offset(params[:offset])
        render json: books, each_serializer: BookSerializer
      end

      def create
        book = Book.new(book_params)

        if book.save
          success_handler(book, :created)
        else
          raise ApplicationError::BadRequest(book.errors)
        end
      end

      def destroy
        Book.find(params[:id]).destroy!
        head :no_content
      end

      private

      def limit
        [
          params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i,
          MAX_PAGINATION_LIMIT
        ].min
      end

      def book_params
        params.require(:book).permit(:title, :author_id, :price)
      end
    end

  end
end