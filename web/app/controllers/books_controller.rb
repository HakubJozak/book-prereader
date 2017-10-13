class BooksController < ApplicationController
  def new

  end

  def create
    Book.create(source_uri: text_from_uri,
                text: uri)

  end

  def show
    
  end

  private

  def uri
    params.require(:book_uri)
  end
  
  def text_from_uri
    open(uri)
  end
end
