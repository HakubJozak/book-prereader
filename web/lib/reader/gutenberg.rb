require 'open-uri'


module Reader
  class Gutenberg
    START_REGEXP = %r{^.*\*\*\*START OF THE PROJECT GUTENBERG EBOOK (.*)\*\*\*}
    attr_reader :name, :content

    def initialize(uri)
      @uri = uri
      parse!
    end

    private

    def parse!
      m = raw.match(START_REGEXP)
      @name = m[1]
      @content = raw[m.end(0)..-1]
    end

    def raw
      @raw ||= open(@uri).read
    end
  end
end
