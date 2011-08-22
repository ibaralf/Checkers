require 'checkers'

puts "Welcome, let's play some checkers!"
puts "Enter 'stop' to quit game"
puts "      'show to see the board"
board = Checkers.new()
board.showBoard
mymove = ""
moveAgain = ""
alternate = false

while (mymove != "stop")
    who = "Red"
    if (alternate)
        who = "White"
    end
    puts "#{who}, it's #{moveAgain}your turn,"
    puts "Please enter your move (e.g. a1 => b2):"
    mymove = gets
    mymove = mymove.gsub(/\n/,"")

    if (mymove != "stop" && mymove != "show")
        goodMove = board.doTurn(who, mymove)
        if (goodMove)
            moveAgain = ""
            alternate = !alternate
        else
            moveAgain = "still "
        end
    else
        if (mymove == "show")
            board.showBoard
        end
    end
end