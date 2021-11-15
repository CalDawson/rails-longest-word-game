require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    @word = params[:score]
    @letters = params[:letters]
    if english_word?(@word) && included?(@word, @letters)
      @score = "Well Done, you score #{attempt.size} points, great job!!"
    elsif english_word?(@word) == false
      @score =  "That word is not English, Try Again!!"
    elsif included?(@word, @letters) == false
      return "That word is not Real, Try Again!!"
    end
  end



  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end


  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
end
