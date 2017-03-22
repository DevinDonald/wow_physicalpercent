-- Called by weakauras to get the value to display
function(...)
    
    local current_time = GetTime()
    local total_physical = 0
    local total_spell = 0
    
	
	
    -- iterate through damage_table
    local i = 1
    while aura_env.damage_table[i] do
        
        local timestamp = aura_env.damage_table[i][1]
        local dmg       = aura_env.damage_table[i][2]
        local school    = aura_env.damage_table[i][3]
        
        --if the damage happened outside of the timewindow
        if current_time > timestamp + aura_env.track_time then
            -- then remove the entry.  Don't increment i because the object at i is being removed
            table.remove(aura_env.table, i)
        else 
            -- else see if it's physical or spell and add it to the total
            if school == SCHOOL_MASK_NONE then
                -- wtf is this?
                print("SCHOOL_MASK_NONE encountered")
            elseif school == SCHOOL_MASK_PHYSICAL then
                total_physical = total_physical + dmg
            else
                total_spell = total_spell + dmg
            end
            
            i = i + 1
            
        end
    end
    
    local percent_physical = 0
	
    -- Prevent division by 0
	if total_spell == 0 then
		if total_physical == 0 then 
			-- both spell and physical are 0
			percent_physical = 0
		else 
			-- spell is 0 physical is not 0
			percent_physical = 100
		end
	else
		-- spell is not 0, proceed as normal and round to 1 decimal
		percent_physical = tonumber(string.format("%.1f", (total_spell / total_physical * 100)))
	end
	
	
	-- return
    return percent_physical
    
end

