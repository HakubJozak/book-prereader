require 'open-uri'


class Book < ApplicationRecord

  has_many :placements
  has_many :words, through: :placements

  before_create :download_content

  def name
    read_attribute(:name) || 'Untitled'
  end
  
  def vocabulary
    placements.includes(:word).limit(100).order(frequency: :asc)    
  end

  def analyze!
    tokens = []

    # TODO - use Python for lemmatization
    self.content.scan(/\w+|-/).each do |w|
      tokens << w.downcase
    end

    word_count = tokens.size.to_f
    f = tokens.frequency

    Word.where(text_en: tokens).all.each do |word|
      Placement.create(word: word,
                       book: self,
                       frequency: f[word.text_en] / word_count)
    end
  end

  private

  def download_content
    return if self.content.present?

    case source_uri
    when %r{http://www.gutenberg.org/files.*}
      r = ::Reader::Gutenberg.new(source_uri)
      self.name = r.name
      self.content = r.content
    else
      self.content = open(source_uri).read
    end
  end

end
