require 'open-uri'


module Reader
  class Gutenberg
    START_REGEXP = %r{^.*\*\*\*START OF THE PROJECT GUTENBERG EBOOK (.*)\*\*\*}
    END_REGEXP   = %r{^.*\*\*\*END OF THE PROJECT GUTENBERG EBOOK (.*)\*\*\*} 

    attr_reader :name, :content

    def initialize(uri: nil, raw: nil, name: nil)
      if uri
        @uri = uri
      elsif raw
        @raw = raw
      else
        raise 'Supply +uri+ or +raw+'
      end

      parse!
    end

    private

    def parse!
      from = raw.match(START_REGEXP)
      @name = from[1]
      to = raw.match(END_REGEXP)
      @content = raw[from.end(0)..to.begin(0)]
    end

    def raw
      @raw ||= open(@uri).read
    end
  end
end
