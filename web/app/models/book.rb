require 'open-uri'

class Book < ApplicationRecord

  before_create :download_content
  
  def analyze!
    content.strip
  end

  private

  def download_content
    unless content.present?
      self.content = open(source_uri).read
    end
  end
end
