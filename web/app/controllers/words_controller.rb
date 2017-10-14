class WordsController < ApplicationController

  layout false
  before_action :find_word

  
  def update
    @word.update_attributes(known: known?)
  end

  private

  def known?
    params[:known] == 't'
  end

  def find_word
    @word = Word.find(params[:id])
  end
end
