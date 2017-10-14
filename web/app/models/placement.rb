class Placement < ApplicationRecord
  belongs_to :word  
  belongs_to :book

  delegate :text_en, :text_cs, :definition, to: :word
end
