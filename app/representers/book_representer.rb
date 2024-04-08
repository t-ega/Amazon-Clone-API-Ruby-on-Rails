class Bookrepresenter
  def initialize(book)
    @book = book
  end

  def as_json
    {
      author: book.author.full_name,
      title: book.title,
      id: book.id
    }
  end

  private

  attr_reader :book

end

