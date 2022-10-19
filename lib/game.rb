require 'colorize'

def save_game(i, j, hangman_word, correct_guesses, incorrect_guesses)
    Dir.mkdir('../saved_games') unless Dir.exists?('../saved_games')

    save = 1

    while File.exists?("../saved_games/" + save.to_s + ".txt")
        save += 1 
    end
    
    filename = "../saved_games/" + save.to_s + ".txt"
    
    File.open(filename, 'w') do |file|
      file.puts i.to_s
      file.puts j.to_s
      file.puts hangman_word.to_s
      file.puts correct_guesses.join("")
      file.puts incorrect_guesses.join("")
    end
    puts "Your save number is: ".cyan + "#{save.to_s}".cyan.bold
    exit()
end

def load_game
    puts "Please enter your save number".cyan
    file_number = gets.chomp.to_s
    file_array = Array.new

    begin
        File.open("../saved_games/#{file_number}.txt").each do 
            |line| file_array.push(line)
        end
    rescue 
        puts "The specified save number cannot be found".red
    end
    
    return file_array
end

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
    word = gets.chomp.downcase
    if word == "save"
        return word
    elsif !letter?(word) || word.length > 1
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

def draw_man(guess)
    if guess == 1
        puts "       \n       \n       \n       \n       \n       \n=========\n"

        puts "\n"
    elsif guess == 2
        puts "       \n       \n       \n       \n       \n      |\n=========\n"
        puts "\n"
    elsif guess == 3
        puts "       \n       \n       \n       \n      |\n      |\n=========\n"
        puts "\n"
    elsif guess == 4
        puts "       \n       \n       \n      |\n      |\n      |\n=========\n"
        puts "\n"
    elsif guess == 5
        puts "       \n        \n      |\n      |\n      |\n      |\n=========\n"
        puts "\n"
    elsif guess == 6
        puts "       \n      |\n      |\n      |\n      |\n      |\n=========\n"
        puts "\n"
    elsif guess == 7
        puts "  +---+\n      |\n      |\n      |\n      |\n      |\n=========\n"
        puts "\n"
    elsif guess == 8
        puts "  +---+\n  |   |\n      |\n      |\n      |\n      |\n=========\n"
        puts "\n"
    elsif guess == 9
        puts "  +---+\n  |   |\n  O   |\n      |\n      |\n      |\n=========\n"
        puts "\n"
    elsif guess == 10
        puts "  +---+\n  |   |\n  O   |\n /|\\  |\n      |\n      |\n=========\n"
        puts "\n"
    elsif guess == 11
        puts "  +---+\n  |   |\n  O   |\n /|\\  |\n / \\  |\n      |\n=========\n"
        puts "\n"
    end

end

def check_guess(i, j, hangman_word, guess_char, correct_guesses, incorrect_guesses)
    if guess_char.downcase == "save"
        save_game(i, j, hangman_word, correct_guesses, incorrect_guesses)
    end
    
    if incorrect_guesses.include?(guess_char) || correct_guesses.include?(guess_char)
    # check if the player has already guessed the character
        puts "You have already guessed this letter".cyan
        guess_char = get_letter(guess_char)
        check_guess(i, j, hangman_word, guess_char, correct_guesses, incorrect_guesses)

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
    j = 1
    puts "     _                                            
    | |                                            
    | |__   __ _ _ __   __ _ _ __ ___   __ _ _ __  
    | '_ \\ / _` | '_ \\ / _` | '_ ` _ \\ / _` | '_ \\ 
    | | | | (_| | | | | (_| | | | | | | (_| | | | |
    |_| |_|\\__,_|_| |_|\\__, |_| |_| |_|\\__,_|_| |_|
                        __/ |                      
                       |___/     \n
    "
    sleep 0.7
    puts "Type 'load' to start from a previous save".cyan
    puts "Type 'play' to start a new game".green
    puts "\n"
    selection = gets.chomp.downcase

    until selection == "load" || selection == "play"
        puts "Please make a valid selection".red
        selection = gets.chomp.downcase
    end

    if selection == "load"
        load_data = Array.new
        until load_data.length == 5
            load_data = load_game()
        # will ask for your save number until the array is loaded with the right data
        end
        i = load_data[0].to_i
        j = load_data[1].to_i - 1
        hangman_word = load_data[2].chomp
        correct_guesses = load_data[3].chomp.split("")
        incorrect_guesses = load_data[4].chomp.split("")
    end

    puts "\n"
    puts "\n"
    puts "Guess #{j}".green.bold
    puts "\n"
    puts "Word Progress".cyan
    puts correct_guesses.join("")
    puts "\n"
    puts "Incorrect Guesses".red
    puts incorrect_guesses.join("")

    until i == 11
        draw_man(i)
        j += 1
        puts "To save your game type 'save'".yellow
        guess_char = get_letter(guess_char)

        check_guess(i, j, hangman_word, guess_char, correct_guesses, incorrect_guesses)

        if incorrect_guesses.length - i == 1
        # check if the incorrect_guesses increased
            i += 1
        end
        puts "\n"
        puts "\n"
        puts "Guess #{j}".green.bold
        puts "\n"
        puts "Word Progress".cyan
        puts correct_guesses.join("")
        puts "\n"
        puts "Incorrect Guesses".red
        puts incorrect_guesses.join("")
        puts "\n"
        if (correct_guesses - hangman_word.split("")).length == 0
            return puts "You guessed the word ".green + "#{hangman_word}!".green.bold + " Congratulations!".green
        end 
    end
    draw_man(11)
    return puts "You couldn't guess the word ".red + "#{hangman_word}".red.bold + " in time".red
end

hangman_word = pick_random_line()
guess_char = ""
incorrect_guesses = Array.new
correct_guesses = Array.new

lengthen_blank_array(correct_guesses, hangman_word)

run_game(hangman_word, guess_char, correct_guesses, incorrect_guesses)
