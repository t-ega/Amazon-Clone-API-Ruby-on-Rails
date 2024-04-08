require_relative '../../../representers/book_representer'
require_relative '../../../representers/books_representer'

module Api
  module V1
    class BooksController < ApplicationController

      def index
        books = Book.all
        books_json = Booksrepresenter.new(books).as_json

        render json: books
      end

      def create
        book = Book.new(book_params)

        if book.save
          render json: Bookrepresenter.new(book).as_json, status: :created
        else
          render json: book.errors, status: :bad_request
        end
      end

      def destroy
        Book.find(params[:id]).destroy!
        head :no_content
      end

      private

      def book_params
        params.require(:book).permit(:title, :author_id)
      end
    end

  end
end