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

def draw_man(guess_count)
    if guess_count == 0
        puts ""
    end
end

def check_guess(hangman_word, guess_char, correct_guesses, incorrect_guesses)
    if incorrect_guesses.include?(guess_char) || correct_guesses.include?(guess_char)
    # check if the player has already guessed the character
        puts "You have already guessed this letter".cyan
        guess_char = get_letter(guess_char)
        check_guess(hangman_word, guess_char, correct_guesses, incorrect_guesses)

    elsif hangman_word.include?(guess_char)
        hangman_word.split("").each_with_index { |letter, index| 
            if letter == guess_char
                correct_guesses[index] = letter
            end
        }
    else
        incorrect_guesses.push(guess_char)
    end
end

def run_game(hangman_word, guess_char, correct_guesses, incorrect_guesses)
    i = 0
    until i == 11
        puts "#{i}".green
        guess_char = get_letter(guess_char)

        check_guess(hangman_word, guess_char, correct_guesses, incorrect_guesses)

        if incorrect_guesses.length - i == 1
        # check if the incorrect_guesses increased
            i += 1
        end

        puts "\n"
        puts "Correct Guesses".cyan
        puts correct_guesses.join("")
        puts "\n"
        puts "Incorrect Guesses".red
        puts incorrect_guesses.join("")
        puts "\n"
        if (correct_guesses - hangman_word.split("")).length == 0
            return puts "You won! Congratulations!".green.bold
        end 
    end
    return puts "You couldn't guess the word in time".red
end

hangman_word = pick_random_line()
guess_char = ""
incorrect_guesses = Array.new
correct_guesses = Array.new

lengthen_blank_array(correct_guesses, hangman_word)

run_game(hangman_word, guess_char, correct_guesses, incorrect_guesses)

puts hangman_word
