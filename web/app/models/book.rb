require 'open-uri'


class Book < ApplicationRecord

  has_many :placements
  has_many :words, through: :placements

  before_create :download_content
  
  def analyze!
    tokens = []

    # TODO - use Python for lemmatization
    content.scan(/\w+|-/).each do |w|
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
    unless content.present?
      self.content = open(source_uri).read
    end

    # (/\s*|,|\.|!|\?|-|;/)
    tokens = self.content.split.map(&:downcase).uniq


# each do |w|
#       Word.find_or_create_by(text_en: w)
#     end
  end
end
