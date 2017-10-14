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
end



