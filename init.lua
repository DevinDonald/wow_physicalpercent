-- How many seconds to track for
aura_env.track_time = 5



-- Table that holds all the damage taken data
aura_env.damage_table = {}


-- The functions referenced by subevent_lookup (defined below)
-- Return (amount, school)
function swing_damage(amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand)
	-- resisted is how much was absorbed, resisted, etc.  Add it to amount
	if resisted == nil then resisted = 0 end
	return amount + resisted, school
end

function swing_missed(missType, isOffHand, amountMissed)
	-- amountMissed can be nil if it's a dodge and maybe other things. 
	if amountMissed ~= nil then 
		return amountMissed, SCHOOL_MASK_PHYSICAL
	else
		return 0, SCHOOL_MASK_PHYSICAL -- don't know how much, so store as 0.  Maybe change this later.
	end
end

function range_damage(spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand)
	-- Can't find documentation on school vs spellSchool, but they seem to be equal in my testing...
	if resisted == nil then resisted = 0 end
	return amount + resisted, school
end

function range_missed(spellId, spellName, spellSchool, missType, isOffHand, amountMissed)
	-- amountMissed can be nil if it's a dodge and maybe other things. 
	if amountMissed ~= nil then 
		return amountMissed, spellSchool
	else
		return 0, spellSchool  -- don't know how much, so store as 0.  Maybe change this later.
	end
end

-- The rest take the same parameters as range
spell_damage          = range_damage
spell_missed          = range_missed
spell_periodic_damage = range_damage
spell_periodic_missed = range_missed
spell_building_damage = range_damage
spell_building_missed = range_missed


-- Table that holds pointers to functions that'll be called depending on the type of combat_log_event
-- There's also a SPELL_ABSORBED event that fires at the same time as a DAMAGE event.  It tells you more info about the absorb, but all I need is the amount absorbed.
aura_env.subevent_lookup = {
	["SWING_DAMAGE"]          = swing_damage,
	["SWING_MISSED"]          = swing_missed,
	["RANGE_DAMAGE"]          = range_damage,
	["RANGE_MISSED"]          = range_missed,
	["SPELL_DAMAGE"]          = spell_damage,
	["SPELL_MISSED"]          = spell_missed,
	["SPELL_PERIODIC_DAMAGE"] = spell_periodic_damage,
	["SPELL_PERIODIC_MISSED"] = spell_periodic_missed,
	["SPELL_BUILDING_DAMAGE"] = spell_building_damage,
	["SPELL_BUILDING_MISSED"] = spell_building_missed
}
