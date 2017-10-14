require 'rubygems'
require 'json'
require 'epub/parser'

# reader = EPUB::Reader.open("test2.epub")
# reader.pages.each do |page|
#   puts page.title
#   puts page.content
# end



#result = {}
#result['dog'] = 42
#result.to_json

#[ { text: 'dog', frequency: '55' } ].to_json

text = ""

book = EPUB::Parser.parse('test2.epub')
book.each_page_on_spine do |page|
	page.read
	page.content_document.nokogiri

 	text = page.content_document.nokogiri.search('//text()').map(&:text)
#	words = text.split(/\W+/)
#puts text.inspect


#puts text
words = text.join(' ').split(/\W+/)

#result = Hash.new(0)
#words.each { |word| result[word] += 1 }

#puts [ {text: word, frequency: result[word]} ].to_json

#new.sort{|a,b| a[1]<=>b[1]}.each { |elem|
#	puts "\"#{elem[0]}\" has #{elem[1]} occurrences"
#}


h = Hash.new
words.each { |w|
	if h.has_key?(w)
		h[w] = h[w] + 1
	else
		h[w] = 1
end
}


h.sort{|a,b| a[1]<=>b[1]}.each { |elem|
	puts "text:#{elem[0]}, frequency: #{elem[1]} "
}
end

