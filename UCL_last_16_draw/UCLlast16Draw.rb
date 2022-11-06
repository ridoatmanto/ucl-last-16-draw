# Created by Rido Atmanto (https://github.com/ridoatmanto/ucl-last-16-draw)"
# November 5th 2022

class UCLlast16Draw
  def initialize(participants)
    @group_winners = participants.select{ |x| x[:status] == "group_winner" }
    @runner_up     = participants.select{ |x| x[:status] == "runner_up" }
    @possibilities_header_label = "UEFA Champions League Possible Opponent each team"
    @possibilities_header_width = 55
    @draw_header_label   = "UEFA Champions League Sample Draw (last 16 Round)"
    @draw_header_width   = 80
    @max_center_position = 35
  end

  def opponent_candidate(participants, candidate)
    participants.select{ |x| x[:country] != candidate[:country] && x[:group] != candidate[:group]}
  end

  def header(title, area_width)
    header = "\n\t" + title.center(area_width)
    header += "\n\t" + ("_" * area_width).center(area_width) + "\n\n"
    
    header
  end

  def generate_draw
    winners = @group_winners.clone
    draw    = []

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

    generate_draw_by_value(draw)
  end

  def generate_draw_by_value(draw, index=1)
    text = header(@draw_header_label + " ##{index.to_s}", @draw_header_width)

    draw.each do |x|
      winner      = x.first
      runner_up   = x.last
      winner_text = "#{winner[:name]} (#{winner[:country]})/Group #{winner[:group]}"
      
      text += "\t".ljust(@max_center_position-winner_text.length)
      text += "#{winner[:name]} (#{winner[:country]})/Group #{winner[:group]}  vs  "
      text += "#{runner_up[:name]} (#{runner_up[:country]})/Group #{runner_up[:group]}\n\n"
    end

    text + "\n"
  end

  def opponent_possibilities
    text = header(@possibilities_header_label, @possibilities_header_width)

    @group_winners.shuffle.each do |item|
      prefiks = "\t#{item[:name]} (#{item[:country]}) VS "
      text   += prefiks
      
      opponent_candidate(@runner_up, item).each_with_index do |x, index|
        text += "\t" + (" " * (prefiks.length-1)) if (index > 0)
        text += "#{x[:name]} (#{x[:country]})\n"
      end

      text += "\n"
    end

    text
  end

  def all_possibilities
    # Collecting all possibilities by winner
    winners   = @group_winners.clone
    runner_up = @runner_up.clone
    possibilities = []

    winners.length.times do
      reserved_candidate_by_club = {}

      winners.each do |item|
        reserved_candidate_by_club[item] = opponent_candidate(runner_up, item)
      end

      possibilities.push(reserved_candidate_by_club)
      winners = winners.rotate(1)
    end

    # Create General Draw by available candidate
    all_combinations = []
    
    possibilities.each_with_index do |value, index|
      reserved = []

      value.each do |winner, candidate_list|
        reserved.push(candidate_list.map {|candidate| [winner, candidate] })
      end

      get_all_combination(*reserved).each do |item|
        all_combinations.push(item) if check_valid_draw(item)
      end
    end

    {total: format_number(all_combinations.size), last_draw: all_combinations.last}
  end

  def get_all_combination(*arr)
    arr.shift.product(*arr)
  end

  def check_valid_draw(arr)
    reserved_opponent = []

    arr.each_with_index do |item, index|
      return false if reserved_opponent.include?(item.last)
      reserved_opponent.push(item.last)
    end

    true
  end

  def format_number(number)
    num_groups = number.to_s.chars.to_a.reverse.each_slice(3)
    num_groups.map(&:join).join(',').reverse
  end
end
