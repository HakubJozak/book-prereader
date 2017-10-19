require 'open-uri'


class BooksController < ApplicationController
  def new
    @book = Book.new # (source_uri: 'http://www.gutenberg.org/files/308/308-0.txt')
  end

  def create
    if uri.present?
      @book = Book.create(source_uri: uri)
      redirect_to @book
    elsif content.present?
      @book = Book.create(content: content)
      redirect_to @book
    elsif file.present?
      r = ::Reader::Epub.new(file.path)
      @book = Book.create(content: r.content, name: r.name)
      redirect_to @book
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  private

  def content
    book_params[:content]
  end

  def uri
    book_params[:source_uri]
  end

  def file
    book_params[:file]
  end

  def book_params
    params.require(:book).permit(:source_uri, :file, :content)
  end

  helper_method :body_class

  def body_class
    [ params[:controller], params[:action] ].join('-')
  end
end
