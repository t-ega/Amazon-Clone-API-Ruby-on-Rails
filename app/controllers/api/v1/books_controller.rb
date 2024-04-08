module Api
  module V1

    class BooksController < ApplicationController

      def show
        book = Book.first
        render json: book, serializer: BookSerializer
      end

      def index
        books = Book.all

        render json: books, each_serializer: BookSerializer
      end

      def create
        book = Book.new(book_params)

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

      def book_params
        params.require(:book).permit(:title, :author_id)
      end
    end

  end
end