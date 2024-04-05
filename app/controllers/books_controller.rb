class BooksController < ApplicationController
  def index
  end

  def create
    puts book_params
    render json: {:success=> true}
  end

  private
  def book_params
    params.require(:book).permit(:name)
  end
end
