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

def lengthen_blank_array(array, hangman_word)
    i = 0
    until i == hangman_word.length
        array.push("_")
        i += 1
    end
    return array
end

def check_guess(hangman_word, guess_char, correct_guesses)
    if hangman_word.include?(guess_char)
        hangman_word.split("").each_with_index { |letter, index| 
            if letter == guess_char
                correct_guesses[index] = letter
            end
        }
    end
end

hangman_word = "apple" #pick_random_line()
guess_char = get_letter(guess_char)
correct_guesses = Array.new
lengthen_blank_array(correct_guesses, hangman_word)

puts hangman_word
puts guess_char
p correct_guesses 

check_guess(hangman_word, guess_char, correct_guesses)
guess_char = get_letter(guess_char)
p correct_guesses
check_guess(hangman_word, guess_char, correct_guesses)
p correct_guesses
guess_char = get_letter(guess_char)
check_guess(hangman_word, guess_char, correct_guesses)
p correct_guesses
guess_char = get_letter(guess_char)
check_guess(hangman_word, guess_char, correct_guesses)
p correct_guesses
