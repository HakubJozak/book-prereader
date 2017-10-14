require 'open-uri'

class Book < ApplicationRecord

  before_create :download_content
  
  def words
    content.strip.split
  end

  private

  def download_content
    unless content.present?
      self.content = open(source_uri).read
    end

    # (/\s*|,|\.|!|\?|-|;/)
    tokens = self.content.split.map(&:downcase).uniq
    require 'pry' ; binding.pry

# each do |w|
#       Word.find_or_create_by(text_en: w)
#     end
  end
end
