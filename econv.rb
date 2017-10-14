require 'rubygems'
require 'json'
require 'epub/parser'

text = ""
bookname = ARGV[0]

if File.file?(bookname)
  book = EPUB::Parser.parse(bookname)
  book.each_page_on_spine do |page|
    page.read
    page.content_document.nokogiri

    text = page.content_document.nokogiri.search('//text()').map(&:text)
    words = text.join(' ').split(/\W+/)

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
else
  puts "file does not exist\n"
end
