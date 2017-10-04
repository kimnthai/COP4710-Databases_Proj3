# COP4710-Database_Proj3
Write two plpgsql functions and run them against the NBA statistics data. Project is done and tested in catalyst.cse.usf.edu. Started up by created a new database.

 write the following two functions in plpgsql and test them in the NBA-xxx database:

1. Write a function named player_height_rank that, given the first name and last name of a player, returns the rank of that player based on his height. Note that the players table stores height information in feet and inches, thus you have to sort the players by total height instead of h_feet or h_inches to get the rank. For a player, his rank is defined as one plus the number of players taller than he is. Note that players with the exact same height should have the same rank. Some examples according to the NBA database are: Gheorghe Muresan ranked 1 with a height of 7 feet and 7 inches; Manute Bol ranked 2nd (7 ft. 6 in.); Ming Yao and three others ranked 3rd (7 ft. 5 in.); and five other players with height 7 ft. 4 in. all ranked 7th, etc. If the name given does not match any player in the players table, the function returns 0.

2. Write a function named player_weight_var that, given a team ID (as the 1st parameter) and a year (as the 2nd parameter), returns the variance (as a floating number) of the weights of all players played in that team in the given season. Note that, as a basic statistical measure of a set of numbers, the variance is defined as the average of the squared differences from the mean. If y
