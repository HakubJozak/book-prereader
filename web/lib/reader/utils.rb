module Reader
  module Utils
    private

    def tokenize(text)
      tmp = Tempfile.new(['dibook', '.txt'])
      tmp.write(text)
      tmp.close
      r = `python3 ../clean.py #{tmp.path}`
      JSON.parse(r)
    ensure
      tmp.unlink
    end
  end
end
