class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @player1 = name1
    @player2 = name2
    @cups = Array.new(14){Array.new}
    place_stones
  end

  def place_stones
    @cups.each_with_index do |ele, i|
      4.times do
        ele << :stone unless i == 13 || i == 6
      end
    end
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if start_pos <= 0   || start_pos >= 12 ||
                                   start_pos == 6
    raise "Invalid starting cup" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_name)
    stones = @cups[start_pos]
    @cups[start_pos] = []

    i = start_pos
    until stones.empty?
      i += 1
      i = 0 if i > 13
      if i == 6
        @cups[6] << stones.pop if @player1 == current_name
      elsif i == 13
        @cups[13] << stones.pop if @player2 == current_name
      else
        @cups[i] << stones.pop
      end
    end

    render
    next_turn(i)
  end

  def next_turn(ending_cup_idx)
    if ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    elsif @cups[ending_cup_idx].count == 1
      :switch
    else
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def cups_empty?
    @cups[0..5].all?{|x| x.empty?} || @cups[7..12].all?{|x| x.empty?}
  end

  def winner
    if @cups[6].count > @cups[13].count
      @player1
    elsif @cups[6].count < @cups[13].count
      @player2
    else
      :draw
    end
  end
end
