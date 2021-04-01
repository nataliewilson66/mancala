class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = Array.new(14) { Array.new }
    (0..5).each do |idx|
      4.times { @cups[idx] << :stone }
    end
    (7..12).each do |idx|
      4.times { @cups[idx] << :stone }
    end
    @player1 = name1
    @player2 = name2
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
  end

  def valid_move?(start_pos)
    if start_pos < 0 || start_pos > 12 || start_pos == 6
      raise 'Invalid starting cup'
    elsif cups[start_pos].empty?
      raise 'Starting cup is empty'
    end
    true
  end

  def make_move(start_pos, current_player_name)
    num_stones = cups[start_pos].length
    curr_pos = start_pos
    cups[start_pos].clear
    until num_stones == 0
      curr_pos = (curr_pos + 1) % 14
      if current_player_name == @player1
        unless curr_pos == 13
          cups[curr_pos] << :stone
          num_stones -= 1
        end
      elsif current_player_name == @player2
        unless curr_pos == 6
          cups[curr_pos] << :stone
          num_stones -= 1
        end
      end
    end
    render
    next_turn(curr_pos)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    if ending_cup_idx == 6 || ending_cup_idx == 13
      return :prompt
    elsif cups[ending_cup_idx].length == 1
      return :switch
    else
      return ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    return true if cups[0..5].all? { |cup| cup.empty? }
    return true if cups[7..12].all? { |cup| cup.empty? }
    false
  end

  def winner
    player1_score = cups[6].length
    player2_score = cups[13].length
    if player1_score == player2_score
      return :draw
    elsif player1_score > player2_score
      return @player1
    else
      return @player2
    end
  end
end
