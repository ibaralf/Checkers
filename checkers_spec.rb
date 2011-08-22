require 'checkers'

describe Checkers do

    before(:all) do
        @checkers = Checkers.new
    end

    describe "#Create", "When created" do
        it "should have a new board" do
            @checkers.should be_newBoard
        end
        it "should have a fresh board" do
            @checkers.should be_freshBoard
        end
    end

    describe "#Moves", "When checker pieces move" do
        it "should be able to go diagonally" do
            helper_makeaMove("Red", "a3=>b4")
            @checkers.getSquareStatus("a3").should == 'blank'
            @checkers.getSquareStatus("b4").should == 'red'
            helper_makeaMove("White", "b6=>a5")
            @checkers.getSquareStatus("b6").should == 'blank'
            @checkers.getSquareStatus("a5").should == 'white'
        end
        it "should not be able to move backwards" do
            helper_makeaMove("Red", "b4=>a3")
            @checkers.getSquareStatus("a3").should == 'blank'
            @checkers.getSquareStatus("b4").should == 'red'
        end
        it "should not be able to go horizontally" do
            @checkers.should_not be_moveChecker("Red", "e3=>e4")
        end
        it "should not be able to go to an occupied space" do
            # occupied by opponent
            @checkers.getSquareStatus("a5").should == 'white'
            @checkers.getSquareStatus("b4").should == 'red'
            helper_makeaMove("White", "a5=>b4")
            @checkers.getSquareStatus("b4").should_not equal('white')
            # occupied by checker piece of same color
            @checkers.getSquareStatus("b4").should == 'red'
            @checkers.getSquareStatus("c3").should == 'red'
            @checkers.should_not be_moveChecker("Red", "c3=>b4")
        end
    end

    def helper_makeaMove(who, testMove)
        @checkers.doTurn(who, testMove)
    end

end