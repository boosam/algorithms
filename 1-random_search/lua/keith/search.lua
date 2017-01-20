function search(space, tries)
	best = nil;

	for i = 1, tries do  -- The range includes both ends.
		random = getRandom(space);
		cost = getCost(random);
		if(best == nil) then
			best = random;
		end
		if(cost<best) then
			best = random;
		end
		
	end

	return best
end


function getCost(candidate)
	return candidate;
end

function getRandom(space)
	rand = math.random(#space);
	--io.write('random: ' .. rand .. ' | ' ..space[rand])
	return space[rand]
end

max_tries = 2;
search_space = {8,7,2,6,9,2,8,9,10,-1};

best = search(search_space, max_tries);

io.write('the best result is: ' .. best .. '\n')