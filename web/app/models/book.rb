require 'open-uri'


class Book < ApplicationRecord

  include Reader::Utils
  
  has_many :placements
  has_many :words, through: :placements

  before_create :prepare_tokens!

  def name
    read_attribute(:name) || 'Untitled'
  end
  
  def vocabulary
    placements.includes(:word).limit(100).order(frequency: :asc)    
  end

  def analyze!
    tokens = []

    word_count = tokens.size.to_f
    f = tokens.frequency

    Word.where(text_en: self.tokens).all.each do |word|
      Placement.create(word: word,
                       book: self,
                       frequency: f[word.text_en] / word_count)
    end
  end

  private

  def prepare_tokens!
    if content.blank?
      download_content!
    end

    self.tokens  = tokenize(self.content)
  end

  def download_content!
    case source_uri
    when %r{http://www.gutenberg.org/files.*}
      r = ::Reader::Gutenberg.new(source_uri)
      self.name = r.name
      self.content = r.content
    else
      self.name    = 'Unknown Web Page'
      self.content = open(source_uri).read
    end
  end
end
