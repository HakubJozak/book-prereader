require 'open-uri'



def create_words
  three_men_in_a_boat = 'http://www.gutenberg.org/files/308/308-0.txt'
  text = open(three_men_in_a_boat).read

  tokens = []

  text.scan(/\w+|-/) do |s|
    tokens << s.downcase
  end

  tokens.uniq!.each_with_index do |str,i|
    puts i if i % 100 == 0
    Word.create(text_en: str)  
  end

  puts "Inserted #{Word.count} words."
end

def translate_words
  scope = Word.where(text_cs: nil)
  total = scope.count

  scope.each.with_index do |w,i|
    puts "#{i}/#{total}" if i % 100 == 0
    w.translate!
  end
end

def cleanup_words
  Word.where(text_en: STOPWORDS).delete_all
end

# Word.delete_all
# create_words
#cleanup_words
translate_words
