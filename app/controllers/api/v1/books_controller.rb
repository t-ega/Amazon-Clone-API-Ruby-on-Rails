module Api
  module V1
    class BooksController < ApplicationController
      def index
        books = Book.all
        render json: books
      end

      def create
        puts params
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
        params.require(:book).permit(:author, :title)
      end
    end

  end
end