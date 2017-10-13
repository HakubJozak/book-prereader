require 'open-uri'


class BooksController < ApplicationController
  def new
    @book = Book.new(source_uri: 'http://www.gutenberg.org/files/308/308-0.txt')
  end

  def create
    @book = Book.create(name: 'Unknown Book',
                        source_uri: uri)

    @book.analyze!
    redirect_to @book
  end

  def show
    @book = Book.find(params[:id])
    @words 
  end

  private

  def uri
    params.require(:book).permit(:source_uri)[:source_uri]
  end

  helper_method :body_class

  def body_class
    [ params[:controller], params[:action] ].join('-')
  end
end
