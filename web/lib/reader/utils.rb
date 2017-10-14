module Reader
  module Utils
    private

    def tfidf(text)
      Dir.chdir('..') do 
        list = run_python("python3 get_tfidf.py",text)

        # hack the result
        result = {}
        list.each do |h|
          result[h.keys.first] = h.values.first
        end

        result
      end
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
