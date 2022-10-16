require 'colorize'

def pick_random_line
    word = File.readlines("../sample_words.txt").sample.chomp

    if word.length < 5 || word.length > 12
        pick_random_line()
    else
        return word
    end
end

def letter?(lookAhead)
    lookAhead.match?(/[[:alpha:]]/)
end

def get_letter(word)
    if !letter?(word = gets.chomp.downcase) || word.length > 1
        puts "Please make a valid input".red
        word = get_letter(word)
    end

    return word
end

hangman_word = pick_random_line()
guess_char = get_letter(guess_char)

puts hangman_word
puts guess_char
