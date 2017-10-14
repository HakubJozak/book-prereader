require 'rubygems'
require 'json'
require 'epub/parser'

# reader = EPUB::Reader.open("test2.epub")
# reader.pages.each do |page|
#   puts page.title
#   puts page.content
# end



result = {}
result['dog'] = 42
result.to_json

[ { text: 'dog', frequency: '55' } ].to_json


require 'epub/parser'

book = EPUB::Parser.parse('test2.epub')
book.metadata.titles # => Array of EPUB::Publication::Package::Metadata::Title. Main title, subtitle, etc...
book.metadata.title # => Title string including all titles
book.metadata.creators # => Creators(authors)
book.each_page_on_spine do |page|
  page.media_type # => "application/xhtml+xml"
  page.entry_name # => "OPS/nav.xhtml" entry name in EPUB package(zip archive)
  page.read # => raw content document
  page.content_document.nokogiri # => Nokogiri::XML::Document. The same to Nokogiri.XML(page.read)

  puts page.content_document.nokogiri.search('//text()').map(&:text)
  
  # do something more
  #    :
end
