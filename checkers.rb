class Checkers

    def initialize()
        createBoard
    end

    def moveChecker?(who, turn)
        return doTurn(who, turn)
    end

    def doTurn(who, turn)
        if (! checkTurnFormat(turn))
            puts "Move format is not correct (e.g. 'a3 => b4')"
            return false
        else
            fromPosition = turn.split("=>")[0].downcase.strip
            toPosition = turn.split("=>")[1].downcase.strip
            goodMove = makeMove(who.downcase!, fromPosition, toPosition)
            return goodMove
        end
    end

    def checkTurnFormat(turn)
        regex = /\S\d\s*=>\s*\S\d/
        chk = regex =~ turn
        if ( chk.nil?)
            return false
        end
        return true
    end

    def makeMove(col, ff, tt)
        success = false
        if (! @squares.has_key?(ff) || ! @squares.has_key?(tt) )
            puts "Sorry, position is not valid."
        elsif (@squares[ff].getColor != col)
            puts "That's not your checkers, your color is #{col}."
        elsif (@squares[tt].getColor != "blank")
            puts "You can't move there, square is occupied."
        elsif (! checkForwardMove(col, ff, tt))
            puts "You can only move forward and only 1 diagonal space."
        else
            success = true
            puts "Great move!"
            @squares[ff].setColor("blank")
            @squares[tt].setColor(col)
        end
        return success
    end

    def showBoard
        puts "-------------"
        8.downto(1) {|i|
            showRowStatus(i)
            puts " "
        }
        puts "-------------"
    end

    def showRowStatus(rowNum)
        ["a", "b", "c", "d", "e", "f", "g", "h"].each {|j|
            skey = "#{j}" + "#{rowNum}"
            if (@squares.has_key?(skey))
                scolor = @squares[skey].getColor
                if (scolor == "white")
                    print "W"
                elsif (scolor == "red")
                    print "R"
                else
                    print " "
                end
            else
                print " "
            end


        }
    end

    def checkForwardMove(col, ff, tt)
        yesForward = false
        fromNumber = ff.match(/\d+/)[0].to_i
        toNumber = tt.match(/\d+/)[0].to_i
        diff = toNumber - fromNumber
        # puts "FROM TO #{fromNumber} ===> #{toNumber}"
        if (col == "white")
            if (fromNumber > toNumber && diff.abs == 1)
                yesForward = true
            end
        else
            if (toNumber > fromNumber && diff.abs == 1)
                yesForward = true
            end
        end
        return yesForward
    end

    def createBoard
        @squares = Hash.new(32)
        @squares["a1"] = Square.new("a", 1, "red")
        @squares["c1"] = Square.new("c", 1, "red")
        @squares["e1"] = Square.new("e", 1, "red")
        @squares["g1"] = Square.new("g", 1, "red")
        @squares["b2"] = Square.new("b", 2, "red")
        @squares["d2"] = Square.new("d", 2, "red")
        @squares["f2"] = Square.new("f", 2, "red")
        @squares["h2"] = Square.new("h", 2, "red")
        @squares["a3"] = Square.new("a", 3, "red")
        @squares["c3"] = Square.new("c", 3, "red")
        @squares["e3"] = Square.new("e", 3, "red")
        @squares["g3"] = Square.new("g", 3, "red")

        @squares["b4"] = Square.new("b", 4, "blank")
        @squares["d4"] = Square.new("d", 4, "blank")
        @squares["f4"] = Square.new("f", 4, "blank")
        @squares["h4"] = Square.new("h", 4, "blank")
        @squares["a5"] = Square.new("a", 5, "blank")
        @squares["c5"] = Square.new("c", 5, "blank")
        @squares["e5"] = Square.new("e", 5, "blank")
        @squares["g5"] = Square.new("g", 5, "blank")

        @squares["b6"] = Square.new("b", 6, "white")
        @squares["d6"] = Square.new("d", 6, "white")
        @squares["f6"] = Square.new("f", 6, "white")
        @squares["h6"] = Square.new("h", 6, "white")
        @squares["a7"] = Square.new("a", 7, "white")
        @squares["c7"] = Square.new("c", 7, "white")
        @squares["e7"] = Square.new("e", 7, "white")
        @squares["g7"] = Square.new("g", 7, "white")
        @squares["b8"] = Square.new("b", 8, "white")
        @squares["d8"] = Square.new("d", 8, "white")
        @squares["f8"] = Square.new("f", 8, "white")
        @squares["h8"] = Square.new("h", 8, "white")

    end

    def getSquareStatus(whichSquare)
        rval = nil
        if (@squares[whichSquare].nil?)
            puts "NON Existent Square, must be a-h, 1-8"
        else
            rval = @squares[whichSquare].getColor
        end
        return rval
    end

    def newBoard?
        hasBoard = true
        if (@squares.nil?)
            hasBoard = false
        elsif(@squares.size() != 32)
            hasBoard = false
        end
        return hasBoard
    end

    def freshBoard?
        isFresh = true
        reds = ['a1','c1','e1','g1','b2','d2','f2','h2','a3','c3','e3','g3']
        whites = ['b6','d6','f6','h6','a7','c7','e7','g7','b8','d8','f8','h8']
        blanks = ['b4','d4','f4','h4','a5','c5','e5','g5']
        reds.each { |i|
            if (@squares[i].nil? || @squares[i].getColor != 'red')
                isFresh = false
            end
        }
        whites.each { |i|
            if (@squares[i].nil? || @squares[i].getColor != 'white')
                isFresh = false
            end
        }
        blanks.each { |i|
            if (@squares[i].nil? || @squares[i].getColor != 'blank')
                isFresh = false
            end
        }
        return isFresh
    end

    class Square
        def initialize(posx, posy, cl)
            @x = convertToInt(posx)
            @y = posy
            @occupied = cl
        end

        def getColor
            return @occupied
        end

        def setColor(cl)
            @occupied = cl
        end

        def convertToInt(xx)
            @rval = -1
            case xx
                when "a"
                    @rval = 1
                when "b"
                    @rval = 2
                when "c"
                    @rval = 3
                when "d"
                    @rval = 4
                when "e"
                    @rval = 5
                when "f"
                    @rval = 6
                when "g"
                    @rval = 7
                when "h"
                    @rval = 8
            end
            return @rval
        end

    end


end

