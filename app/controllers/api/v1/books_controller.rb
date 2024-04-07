require_relative '../../../representers/book_representer'

module Api
  module V1
    class BooksController < ApplicationController

      def index
        books = Book.all
        books_json = Booksrepresenter.new(books).as_json

        render json: books_json
      end

      def create
        puts params
        author = Author.create(author_params)
        book = Book.new(book_params.merge({author_id: author.id}))

        if book.save
          render json: book, status: :created
        else
          render json: book.errors, status: :bad_request
        end
      end

      def destroy
        Book.find(params[:id]).destroy!
        head :no_content
      end

      private

      def author_params
        params.require(:author).permit(:first_name, :last_name, :age)
      end

      def book_params
        params.require(:book).permit(:author, :title)
      end
    end

  end
end