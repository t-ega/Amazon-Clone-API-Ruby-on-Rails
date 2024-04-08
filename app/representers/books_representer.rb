class Booksrepresenter
  def initialize(books)
    @books = books
  end

  def as_json
    books.map do |book|
      {
        author: book.author.full_name,
        title: book.title,
        id: book.id
      }
    end
  end

  private

  attr_reader :books

end

