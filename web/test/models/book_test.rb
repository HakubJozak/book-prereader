require 'test_helper'



class BookTest < ActiveSupport::TestCase
  setup do
    @txt = File.new('test/fixtures/files/three_men.txt').read    
  end

  test 'gutentberg' do
    r = Reader::Gutenberg.new(raw: @txt)
    assert_not_empty r.content
  end

  test 'save book with tokens' do
    b = Book.create(name: 'test', content: @txt)
    assert_not_empty b.tokens
  end

  test 'holmes' do
    Book.create(source_uri: 'http://www.gutenberg.org/cache/epub/1661/pg1661.txt')
  end

  test 'alice' do
    Book.create(source_uri: 'http://www.gutenberg.org/files/11/11-0.txt')
  end

  test 'huckleberry' do
    Book.create(source_uri: 'http://www.gutenberg.org/files/76/76-0.txt')    
  end

end



