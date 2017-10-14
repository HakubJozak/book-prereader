require 'open-uri'


module Reader
  class Epub
    attr_reader :name, :content

    def initialize(path)
      @path = path
      parse!
    end

    private

    def parse!
      book = EPUB::Parser.parse(@path)
      @name = book.metadata.title
      buffer = StringIO.new

      book.each_page_on_spine do |page|
        page.read
        page.content_document.nokogiri

        buffer << page.content_document.nokogiri.search('//text()').map(&:text)
      end

      @content = buffer.text
    end

    def raw
      @raw ||= open(@uri).read
    end
  end
end
