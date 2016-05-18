#  Hangman

min_word_length = 5
max_word_length = 10
guesses_allowed = 6

word_list = []
$guess_list = []

f = File.open("/usr/share/dict/words", "r")

f.each do |line|
  if line.length <= max_word_length && line.length >= min_word_length
    word_list.push line.chomp
  end
end

word = word_list[rand(word_list.count)]
word_length = word.length

$letters = word.downcase.split("")

$correct_g = []

0.upto word_length - 1 do |x|
  $correct_g[x] = "_"
end

$allowed_chars = []
$freq_list = {}

97.upto 122 do |x|
  $allowed_chars.push x.chr
  $freq_list[x.chr] = 0
end

word_list.each do |item|
  item.split("").each do |letter|
    $freq_list[letter.downcase] += 1
  end
end

$freq_list = $freq_list.sort_by { |a, b| b }
$freq_list = $freq_list.map { |a,b| a }

game_end = false
win = false

$hints = 3

def get_hint
  allowed_hints = $freq_list
  allowed_hints = allowed_hints - $correct_g.uniq
  allowed_hints = allowed_hints - $guess_list.uniq

  index = 0

  until index == allowed_hints.length - 1
    unless $letters.include? allowed_hints[index]
      allowed_hints.delete_at(index)
      next
    else
      index += 1
    end
  end

  if $hints < 1
    return nil
  else
    $hints -= 1
    return allowed_hints[0]
  end

end


until game_end

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

  if $guess_list.include? guess
    puts "You already guessed that."
    puts "Try again."
    next
  end

  if guess.downcase == word.downcase
    puts "What an amazing guess!"
    game_end = true
    win = true
  end


  unless $allowed_chars.include? guess
    puts "That is not a valid character."
    next
  else
    $guess_list.push guess
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
    game_end = true
    win = true
  end

  if guesses_allowed == 0
    game_end = true
  end
end

puts "The game has ended."

if win
  puts "You win!"
else
  puts "You lose!"
end

print "The word was "
print $letters.join
puts "."
