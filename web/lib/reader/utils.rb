module Reader
  module Utils
    private

    def tfidf
      run_python("python3 ../get_tfidf.py",text)      
    end

    def run_python(cmd,text)
      tmp = Tempfile.new(['dibook', '.txt'])
      tmp.write(text)
      tmp.close
      r = `#{cmd} #{tmp.path}`      
      JSON.parse(r)
    ensure
      tmp.unlink
    end

    def tokenize(text)
      run_python("python3 ../clean.py",text)
    end

  end
end
