/************************************************************************
 * Program Name: Databases_Project3.sql                                 *
 *                                                                      *
 * Purpose: write two plpgsql functions and run them against the 		*
 *			NBA statistics data         								*
 *                                                                      *
 *                                                                      *
 *                                                                      *
 * Author: Kim Ngan Thai                      COP 4710 Databases        *
 ************************************************************************/

-- function 1 declaration

CREATE OR REPLACE FUNCTION player_height_rank (firstname VARCHAR, lastname VARCHAR) RETURNS int AS $$
DECLARE
	t_height float := 0.0;
	rank INTEGER := 1;
   	r record;   
BEGIN

/*-----------------------------------------------
-- compute the rank base on player's height
-- rank = 1 + number of players taller than he is
-- players with the exact same height have same rank
 -----------------------------------------------*/

	select into t_height (P.h_feet *12*2.54 + P.h_inches *2.54) 
	from players as P 
	where P.firstname=$1 and P.lastname=$2;

	-- loop thru all the players
	FOR r IN SELECT (P.h_feet *12*2.54 + P.h_inches *2.54) as other_height, P.firstname, P.lastname
		FROM players as P 
		ORDER BY (P.h_feet *12*2.54 + P.h_inches *2.54) DESC, P.firstname, P.lastname
	    LOOP
	    	IF r.other_height > t_height then 
	    		rank = rank + 1;
	    	END IF;

	    	IF r.firstname = $1 AND r.lastname = $2 THEN
				RETURN rank;
			END IF;

		END LOOP;

	-- if name doesnt match 
	RETURN 0;

END;
$$ LANGUAGE plpgsql;

/*
-- executing the above function for test
*/
-- select * from player_height_rank('Reggie', 'Miller');
-- select * from player_height_rank('Gheorghe', 'Muresan'); -- 1
-- select * from player_height_rank('Manute', 'Bol'); -- 2
-- select * from player_height_rank('Yao', 'Ming'); -- 3
-- select * from player_height_rank('Rik', 'Smits'); --7
-- select * from player_height_rank('Slavko', 'Vranes');


-- function 2 declaration

CREATE OR REPLACE FUNCTION player_weight_var (tid VARCHAR, yr INTEGER) 
RETURNS FLOAT AS $$
DECLARE
   weights_var float := 0.0;
BEGIN
/*----------------------------------------------
-- Find the varian of weights of all players 
-- played in that team in the given season
-----------------------------------------------*/

	SELECT into weights_var (variance(P.weight))
	FROM player_rs PRS INNER JOIN players P ON P.ilkid = PRS.ilkid
	WHERE PRS.tid=$1 and PRS.year=$2
	group by PRS.tid, PRS.year; 

	-- check for NULL value
	IF weights_var IS NULL THEN
		return -1.0;
	ELSE
		return weights_var;
	END IF;

END;
$$ LANGUAGE plpgsql;



