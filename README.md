# UEFA Champions League last 16 draw
Help you generate all possible fixture between all participants.

Main Regulation before last 16 draw fixture.
1. Participants split by two group. Group winners and Group runner up list.
2. The group winner can only meet the runner up.
3. Teams from the same country and same group stage cannot face each other.

***

### Prepare your own drawing

**Option 1:**
1. Download this repo.
2. Open file `example.rb` on you favourite command line(CLI) terminal
3. Make sure your operating system has ruby in it.
```
~ ruby example.rb
```

**Option 2:**
Doing it manually with more explanation.

Collect UEFA Champions League season 2022/2023 participants data and convert into similar format below.

Sample data :
```
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
```

Create class object with participants.
```
require './UCLlast16Draw.rb'

result = UCLlast16Draw.new(participants)
```

Until now you can do 3 things.
1. Generate possible opponent each team following regulation.
2. Generate random draw.
3. Calculate all fixture possibilities.

***

### Sample possible opponent

```
puts result.opponent_possibilities
```
output given 
```

           UEFA Champions League Possible Opponent each team
        _______________________________________________________

        Real Madrid (ESP) VS Liverpool (ENG)
                             Club Brugge (BEL)
                             Inter Milan (ITA)
                             Eintracht Frankfurt (GER)
                             AC Milan (ITA)
                             Borussia Dortmund (GER)
                             Paris Saint-Germain (FRA)


        Napoli (ITA) VS Club Brugge (BEL)
                        Eintracht Frankfurt (GER)
                        RB Leipzig (GER)
                        Borussia Dortmund (GER)
                        Paris Saint-Germain (FRA)


        Tottenham Hotspur (ENG) VS Club Brugge (BEL)
                                   Inter Milan (ITA)
                                   AC Milan (ITA)
                                   RB Leipzig (GER)
                                   Borussia Dortmund (GER)
                                   Paris Saint-Germain (FRA)


        Chelsea (ENG) VS Club Brugge (BEL)
                         Inter Milan (ITA)
                         Eintracht Frankfurt (GER)
                         RB Leipzig (GER)
                         Borussia Dortmund (GER)
                         Paris Saint-Germain (FRA)


        Porto (POR) VS Liverpool (ENG)
                       Inter Milan (ITA)
                       Eintracht Frankfurt (GER)
                       AC Milan (ITA)
                       RB Leipzig (GER)
                       Borussia Dortmund (GER)
                       Paris Saint-Germain (FRA)


        Benfica (POR) VS Liverpool (ENG)
                         Club Brugge (BEL)
                         Inter Milan (ITA)
                         Eintracht Frankfurt (GER)
                         AC Milan (ITA)
                         RB Leipzig (GER)
                         Borussia Dortmund (GER)


        Manchester City (ENG) VS Club Brugge (BEL)
                                 Inter Milan (ITA)
                                 Eintracht Frankfurt (GER)
                                 AC Milan (ITA)
                                 RB Leipzig (GER)
                                 Paris Saint-Germain (FRA)


        Bayern Munich (GER) VS Liverpool (ENG)
                               Club Brugge (BEL)
                               AC Milan (ITA)
                               Paris Saint-Germain (FRA)
```

### Generate Random Draw

```
puts result.generate_draw
```
output given 
```

                      UEFA Champions League Sample Draw (last 16 Round) #1
        ________________________________________________________________________________

                       Porto (POR)/Group B  vs  Borussia Dortmund (GER)/Group G

           Tottenham Hotspur (ENG)/Group D  vs  RB Leipzig (GER)/Group F

                      Napoli (ITA)/Group A  vs  Paris Saint-Germain (FRA)/Group H

                 Real Madrid (ESP)/Group F  vs  Liverpool (ENG)/Group A

                     Chelsea (ENG)/Group E  vs  Club Brugge (BEL)/Group B

               Bayern Munich (GER)/Group C  vs  AC Milan (ITA)/Group E

             Manchester City (ENG)/Group G  vs  Eintracht Frankfurt (GER)/Group D

                     Benfica (POR)/Group H  vs  Inter Milan (ITA)/Group C
```

### Calculate all drawing combination possibilities

```
all = result.all_possibilities
puts "Total Possibilities : #{all[:total]}"
```
output given 
```
   Total Possibilities : 31,008
```

## BONUS

Get the last combination of total possibilities
```
all = result.all_possibilities
puts result.generate_draw_by_value(all[:last_draw], all[:total])
```
output given 
```
                   UEFA Champions League Sample Draw (last 16 Round) #31,008
        ________________________________________________________________________________

                     Benfica (POR)/Group H  vs  Borussia Dortmund (GER)/Group G

                      Napoli (ITA)/Group A  vs  Paris Saint-Germain (FRA)/Group H

                       Porto (POR)/Group B  vs  RB Leipzig (GER)/Group F

               Bayern Munich (GER)/Group C  vs  AC Milan (ITA)/Group E

           Tottenham Hotspur (ENG)/Group D  vs  Inter Milan (ITA)/Group C

                     Chelsea (ENG)/Group E  vs  Eintracht Frankfurt (GER)/Group D

                 Real Madrid (ESP)/Group F  vs  Liverpool (ENG)/Group A

             Manchester City (ENG)/Group G  vs  Club Brugge (BEL)/Group B
``` 

Enjoy it!

**Rido Atmanto**

*Created November 5th 2022*
