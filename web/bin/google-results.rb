


def find_a_word(agent,word)
  page = agent.get('http://www.google.com/')
  page.encoding = 'utf-8'

  google_form = page.form('f')
  google_form.q = word.text_en

  page = agent.submit(google_form, google_form.buttons.first)
  stats = page.css('#resultStats').text
  count = stats.scan(/\d/).join.to_i

  sleep(rand(3))
  
  word.update_column(:google_results, count)
  count
end


agent = Mechanize.new


# agent.set_proxy '78.186.178.153', 8080

Word.where(google_results: nil).find_each.with_index do |word,i|
  begin
    count = find_a_word(agent,word)
    puts "#{i}: #{word.text_en} #{count}"
  rescue Mechanize::ResponseCodeError
    puts "-------- Caught ... retrying --------"
    sleep(10 + rand(30))
    agent = Mechanize.new
    retry
  end
end



#
# Slova,
#  - ktera maji jedno pismeno
#  - vycistit '_'

