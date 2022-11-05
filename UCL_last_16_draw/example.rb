require './UCLlast16Draw.rb'

participants = [
	{status: "group_winner", group: "A", name: "Napoli", country: "ITA"},
	{status: "runner_up", group: "A", name: "Liverpool", country: "ENG"},
	
	{status: "group_winner", group: "B", name: "Porto", country: "POR"},
	{status: "runner_up", group: "B", name: "Club Brugge", country: "BEL"},

	{status: "group_winner", group: "C", name: "Bayern Munich", country: "GER"},
	{status: "runner_up", group: "C", name: "Inter Milan", country: "ITA"},

	{status: "group_winner", group: "D", name: "Tottenham Hotspur", country: "ENG"},
	{status: "runner_up", group: "D", name: "Eintracht Frankfurt", country: "GER"},

	{status: "group_winner", group: "E", name: "Chelsea", country: "ENG"},
	{status: "runner_up", group: "E", name: "AC Milan", country: "ITA"},

	{status: "group_winner", group: "F", name: "Real Madrid", country: "ESP"},
	{status: "runner_up", group: "F", name: "RB Leipzig", country: "GER"},

	{status: "group_winner", group: "G", name: "Manchester City", country: "ENG"},
	{status: "runner_up", group: "G", name: "Borussia Dortmund", country: "GER"},

	{status: "group_winner", group: "H", name: "Benfica", country: "POR"},
	{status: "runner_up", group: "H", name: "Paris Saint-Germain", country: "FRA"}
]

result = UCLlast16Draw.new(participants)

puts result.opponent_possibilities
puts result.generate_draw


all = result.all_possibilities
puts "\tTotal Possibilities : #{all[:total]}"

puts result.generate_draw_by_value(all[:last_draw], all[:total])

puts "Created by Rido Atmanto (https://github.com/ridoatmanto/ucl-last-16-draw)"
