#  Hangman

require "pry"
# word list

min_word_length = 5
max_word_length = 10

word_list = []


f = File.open("/usr/share/dict/words", "r")
f.each do |line|
  if line.length <= max_word_length && line.length >= min_word_length
    word_list.push line.chomp
  end
  #print "line: "
  #puts line
end

guesses_allowed = 6

word = word_list[rand(word_list.count)]
word_length = word.length

$letters = word.downcase.split("")

$correct_g = []
0.upto word_length - 1 do |x|
  #print x
  $correct_g[x] = "_"
end

#binding.pry
$allowed_chars = []


97.upto 122 do |x|
  $allowed_chars.push x.chr
end

game_end = false
win = false

$hints = 3

def get_hint
  #allowed_hints = $allowed_chars
  #allowed_hints.delete $correct_g.uniq
  

  if $hints < 1
    return nil
  else
    #$allowed_chars.each do |x|
    0.upto $letters.count - 1 do |x|
      
      if $letters[x] != $correct_g[x]
        $hints -= 1
        binding.pry
        return $letters[x]
      end
      
    end
  end
end


until game_end
  
  #binding.pry
  $correct_g.each do |x|
    print x
    print " "
  end
  puts
  puts "You have #{guesses_allowed} guesses left (#{$hints} hints left)."
  print "What is your guess? (Enter '?' for a hint) "

  guess = gets.chomp.to_s.downcase

  if guess == "?"
    guess = get_hint
  end
  if guess == nil
    puts "You have no more hints!"
    next
  end


  
  unless $allowed_chars.include? guess
    puts "That is not a valid character."
    next
  end

  if guess.downcase == word.downcase
    puts "What an amazing guess!"
    game_end = true
    win = true
  end
  
  if $letters.include? guess
    0.upto word_length - 1 do |x|
      if guess == $letters[x]
        $correct_g[x] = guess
      end
    end
  else
    guesses_allowed -= 1
  end

  if $correct_g == $letters
    #binding.pry
    game_end = true
    win = true
  end

  if guesses_allowed == 0
    game_end = true
  end


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
