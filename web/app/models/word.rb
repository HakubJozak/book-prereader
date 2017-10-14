class Word < ApplicationRecord
  validates :text_en, presence: true

  # has_many :placements
  # has_many :books, through: :placements

  # transient attribute used for concrete book
  attr_accessor :frequency

  def translate!
    out = `echo #{text_en} | translate-bin -s google -f en -t cs`
    self.text_cs = out.gsub(/.*>/,'').strip
    save!
  end

  def definition
    wordnet
  end

  # def definitions
  #   return @definitions if @definitions.present?
  #   @definitions = []

  #   wordnet.lines.each do |l|
  #     @definitions
  #   end
  # end

  private

  def wordnet
    return @wn if @wn.present?

    @wn = `dict -d wn #{text_en}`

    if @wn.present?
      @wn.gsub! /^From WordNet.*$/,''
      @wn.gsub! /\d+ definitions? found/, ''
      @wn.strip!
      @wn.lines[1..-1].join("\n")
      @wn
    else
      nil
    end
  end

end
