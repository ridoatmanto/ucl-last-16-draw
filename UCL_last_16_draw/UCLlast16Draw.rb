# Created by Rido Atmanto (https://github.com/ridoatmanto/ucl-last-16-draw)"
# November 5th 2022

class UCLlast16Draw
  def initialize(participants)
    @group_winners = participants.select{ |x| x[:status] == "group_winner" }
    @runner_up     = participants.select{ |x| x[:status] == "runner_up" }
  end

  def opponent_candidate(participants, candidate)
    participants.select{ |x| x[:country] != candidate[:country] && x[:group] != candidate[:group]}
  end

  def header(title, area_width)
    header = "\n"
    header += "\t"
    header += title.center(area_width)
    header += "\n\t" + ("_" * area_width).center(area_width) + "\n\n"
    
    header
  end

  def generate_draw
    winners = @group_winners.clone
    draw = []

    while draw.empty?
      available_runner_up = @runner_up.clone

      winners.shuffle.each do |item|
        candidate = opponent_candidate(available_runner_up, item).sample
        
        if candidate.nil?
          draw = []
          break
        end

        draw.push([item, candidate])
        available_runner_up.delete(candidate)
      end
    end

    generate_draw_by_value(draw, 1)
  end

  def generate_draw_by_value(draw, index)
    text = header("UEFA Champions League Sample Draw (last 16 Round) ##{index.to_s}", 80)
    draw.each do |x|
      item      = x.first
      candidate = x.last

      max_position = 35
      winner = "#{item[:name]} (#{item[:country]})/Group #{item[:group]}"
      
      text += "\t".ljust(max_position-winner.length)
      text += "#{item[:name]} (#{item[:country]})/Group #{item[:group]}"
      text += "  vs  "
      text += "#{candidate[:name]} (#{candidate[:country]})/Group #{candidate[:group]}\n\n"
    end

    text + "\n"
  end

  def opponent_possibilities
    text = header("UEFA Champions League Possible Opponent each team", 55)

    @group_winners.shuffle.each do |item|
      beginning = 1
      prefiks = "\t#{item[:name]} (#{item[:country]}) VS "
      
      opponent_candidate(@runner_up, item).map do |x|
        temp = ""
        if (beginning == 1)
            temp += prefiks
            beginning = 0
        else
            temp += "\t" + (" " * (prefiks.length-1))
        end

        temp += "#{x[:name]} (#{x[:country]})\n"
        text += temp
      end

      text += "\n\n"
    end

    text
  end

  def all_possibilities
    text          = "\n"
    number        = 1
    winners       = @group_winners.clone
    runner_up     = @runner_up.clone
    possibilities = []

    # Collecting all possibilities
    winners.length.times do
      reserved_candidate_by_club = {}

      winners.each do |item|
          candidate = opponent_candidate(runner_up, item)
          reserved_candidate_by_club[item] = candidate
      end

      possibilities.push(reserved_candidate_by_club)
      winners = winners.rotate(1)
    end

    all_combinations = []
    total            = 0
    all              = []

    # Create General Draw by available candidate
    possibilities.each_with_index do |value, index|
      reserved = []

      value.each do |k, v|
        temp = []
        v.each do |item|
            temp.push([k,item])
        end
        reserved.push(temp)
      end

      get_all_combination(*reserved).each do |item|
        if check_valid_draw(item)
          all_combinations.push(item)
          total = total + 1 
        end
      end
    end

    {total: format_number(total), last_draw: all_combinations[total-1]}
  end

  def get_all_combination(*arr)
    arr.shift.product(*arr)
  end

  def check_valid_draw(arr)
    reserved_opponent = []

    arr.each_with_index do |item, index|
      if reserved_opponent.include?(item.last)
        return false
      else
        reserved_opponent.push(item.last)   
      end
    end

    true
  end

  def format_number(number)
    num_groups = number.to_s.chars.to_a.reverse.each_slice(3)
    num_groups.map(&:join).join(',').reverse
  end
end
