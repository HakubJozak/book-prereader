require 'test_helper'

class WordTest < ActiveSupport::TestCase
  test 'definition' do
    w = Word.create(text_en: 'dog')
  end


end
