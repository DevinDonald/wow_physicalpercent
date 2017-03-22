-- Called by weakauras on COMBAT_LOG_EVENT_UNFILTERED events
function(event, timestamp, subevent, _, sourceGUID, _, _, _, destGUID, _, _, _, ...)

    -- Make sure the destination is the player 
    if (destGUID == UnitGUID("player")) then
        
		-- Call the correct function based on what subevent is
		local get_dmg = aura_env.subevent_lookup[subevent]
		if(get_dmg) then 
			-- get damage and school
			local damage, school = get_dmg(...)
			
			-- insert
			table.insert(aura_env.damage_table, {timestamp, damage, school})
		end
		-- else subevent wasn't in subevent_lookup, so it can be ignored!
        
    end
end