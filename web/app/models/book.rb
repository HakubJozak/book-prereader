require 'open-uri'


class Book < ApplicationRecord

  include Reader::Utils

  # transient dummy attribute
  # not implemented
  attr_reader :file

  before_create :prepare_tokens!

  def name
    read_attribute(:name) || 'Untitled'
  end

  def vocabulary
    important_words = tfidf(self.tokens.join(' '))

    total = tokens.count.to_f
    f = tokens.frequency

    words = Word.where(text_en: important_words.keys).each do |w|
      w.frequency = f[w.text_en] / total
      w.tfidf = important_words[w.text_en]
    end

    groups = words.group_by(&:known)

    [
      sorted(groups[false]),
      sorted(groups[nil]),
      sorted(groups[true])
    ].flatten
  end
  

  private

  def sorted(group)
    if group
      group.sort { |a,b| b.tfidf <=> a.tfidf }
    else
      []
    end
  end

  def prepare_tokens!
    if content.blank?
      download_content!
    end

    self.tokens  = tokenize(self.content)
  end

  def download_content!
    case source_uri
    when %r{http://www.gutenberg.org/.*}
      r = ::Reader::Gutenberg.new(uri: source_uri)
      self.name = r.name
      self.content = r.content
    else
      self.name    = 'Unknown Web Page'
      self.content = open(source_uri).read
    end
  end
end
