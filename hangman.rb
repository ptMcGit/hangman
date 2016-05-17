#  Hangman

require "pry"
# word list

word_list = [
  "dog",
  "cat",
  "mouse",
  "rabbit",
  "goose",
]

guesses_allowed = 6

word = word_list[rand(word_list.count)]
word_length = word.length



letters = word.downcase.split("")

correct_g = []
0.upto word_length - 1 do |x|
  #print x
  correct_g[x] = "_"
end

#binding.pry

allowed_chars = []

97.upto 122 do |x|
  allowed_chars.push x.chr
end


game_end = false
win = false
until game_end
  
  if guesses_allowed == 0
    game_end = true
  end
  #binding.pry
  correct_g.each do |x|
    print x
    print " "
  end
  puts
  puts "You have #{guesses_allowed} guesses left."
  print "What is your guess? "

  guess = gets.chomp.to_s.downcase

  unless allowed_chars.include? guess
    puts "That is not a valid character."
    next
  end

  if guess.downcase == word.downcase
    puts "What an amazing guess!"
    game_end = true
    win = true
  end
  
  if letters.include? guess
    0.upto word_length - 1 do |x|
      if guess == letters[x]
        correct_g[x] = guess
      end
    end
  else
    guesses_allowed -= 1
  end

  if correct_g == letters
    #binding.pry
    game_end = true
    win = true
  end
  binding.pry
end
#guess.

#binding.pry

puts "The game has ended."

if win
  puts "You win!"
else
  puts "You lose!"
end

#print "enter a word: "