require 'rubygems'
require 'epub/reader'

reader = Epub::Reader.open("test2.epub")
reader.pages.each do |page|
  puts page.title
  puts page.content
end

