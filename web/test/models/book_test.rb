require 'test_helper'



class BookTest < ActiveSupport::TestCase
  test 'gutentberg' do
    txt = File.new('test/fixtures/files/three_men.txt').read
    r = Reader::Gutenberg.new(raw: txt)
    
  end
end
