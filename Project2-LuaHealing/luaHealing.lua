--Things Lua needs to use for MacroQuest
local mq = require('mq')
local PackageMan = require('mq/PackageMan')
--local lfs = PackageMan.Require('luafilesystem', 'lfs')

--Spells for the healer macro
healingSpell = "Light Healing"
-- Healing
buffSpell = "Strengthen"
--frenzy
debuffSpell = "Drowsy"
--Disempower
dmgSpell = "Frost Rift"
--Spirit strike

--Memorizing spells
function memSpells(healingSpell, buffSpell, debuffSpell, dmgSpell)

    --Healing spell
  mq.cmd("/memspell 1 " .. "\"" .. healingSpell .. "\"")
  print("Delaying 10 seconds to memorize " .. "\"" .. healingSpell .. "\"")
  mq.delay("10s")

    --Buff Spell
  mq.cmd("/memspell 2 " .. "\"" .. buffSpell .. "\"")
  print("Delaying 10 seconds to memorize " .. "\"" .. buffSpell .. "\"")
  mq.delay("10s")

    --Debuff Spell
  mq.cmd("/memspell 3 " .. "\"" .. debuffSpell .. "\"")
  print("Delaying 10 seconds to memorize " .. "\"" .. debuffSpell .. "\"")
  mq.delay("10s")

    --Damage Spell
  mq.cmd("/memspell 4 " .. "\"" .. dmgSpell .. "\"")
  print("Delaying 10 seconds to memorize " .. "\"" .. dmgSpell .. "\"")
  mq.delay("10s")

     --Yippieeee
  print("Support is ready")

end

--Main Function
function main()
  tankName = ""

  --Position of the tank and dps
  tankPos = 0

  --Checking group has enough members
  if mq.TLO.Group() == nil or tonumber(mq.TLO.Group()) < 1 then
    print("You need at least 2 group members")
    return
  end

  --Bools if tank / dps in group
  tankFound = false
  dpsFound = false

  --Checking for Tank and DPS
  for i = 1,tonumber(mq.TLO.Group()),1 do
    target(i)
    s = mq.TLO.Target.Class()
--Tank finding our main guy :]
    if (s=="Shadow Knight" or s=="Paladin" or s=="Warrior") then
      tankFound = true
      tankPos = i
    end

  end

  --Tank was found?
  if tankFound == true then
    print("A tank was found.")
  else
    print("No tank found. Exiting...")
    return
   end

  --Previous conditions true
 --Memorize spells
 memSpells(healingSpell, buffSpell, debuffSpell, dmgSpell)

  target(tankPos)

  --Movement
  mq.cmd("/stick hold healer")

  --Forever loop
groupMem = 0
  while true do
	   for groupMem = 1,tonumber(mq.TLO.Group()),1 do
		   HpCheck(tankPos,groupMem)
     end
  end
end



function HpCheck(i, x)
--i = tankPos
--x = group member index
--Targets the next party member
target(x)
--Run through everything needed for party members
if tonumber(mq.TLO.Target.Distance()) < 35 and mq.TLO.Target ~= nil then
    --Target in Combat
  if  tonumber(mq.TLO.Target.PctHPs()) < 99 then
    Heal()
     --Fuck up the loser
    --Sending it tankPos to retarget tank when done
	if x == i then
    Assist(i)
	end
  end
    --Target Chill
  if tonumber(mq.TLO.Target.PctHPs()) == 100 then
    Buff(buffSpell)
    --Target chill and we are in range
	if x == i then
    if tonumber(mq.TLO.Target.Distance()) < 20 then
      MediLoop(i)
		end
    end
  end
end

function Heal()
  --Check Mana
  ManaCheck('h')
  --Pause Movement
  mq.cmd("/Stick pause")
  --Cast spell
  mq.cmd("/cast 1")
  --Time to cast spell
  mq.delay("6s")
  --Movement unpaused
  mq.cmd("/Stick unpause")
end

function Buff(buffSpell)
  if mq.TLO.Target.Buff(buffSpell).ID() == nil then
    --Buff not active
    ManaCheck('b')
    --Move pause
    mq.cmd("/Stick pause")
  --Casting buff
    mq.cmd("/cast 2")
    --Delay to cast spell
    mq.delay("6s")
    --Move unpasue
    mq.cmd("/Stick unpause")
  end
end

function ManaCheck(SpellCase)
	--Check for mana with healling spell
	if SpellCase == 'h' then
  if tonumber(mq.TLO.Me.CurrentMana()) < tonumber(mq.Spell[healingSpell].Mana()) then
    Medi('h')
  end
	end
	--Check for mana with buff spell
	if SpellCase == 'b' then
  if tonumber(mq.TLO.Me.CurrentMana()) < tonumber(mq.Spell[buffSpell].Mana()) then
    Medi('b')
  end
	end
	--Check for mana with both debuff and damage spell
	if SpellCase == 'a' then
  if tonumber(mq.TLO.Me.CurrentMana()) < (tonumber(mq.Spell[dmgSpell].Mana())+tonumber(mq.Spell[debuffSpell].Mana())) then
    Medi('a')
  end
	end
end

function Medi(medCase)
  mq.cmd("/Stick pause")
  mq.cmd("/Sit")
  print("Meditating for mana for spell")
	--Condition for medi loop
	--Vars for loop
medCon = true
	while medCon do
		--For healing spell
		if mediCase == 'h' then
			if tonumber(mq.TLO.Me.CurrentMana()) == tonumber(mq.Spell[healingSpell].Mana()) then
				medCon = false
			end
		end
		--for buff spell
		if mediCase == 'b' then
			if tonumber(mq.TLO.Me.CurrentMana()) == tonumber(mq.Spell[buffSpell].Mana()) then
				medCon = false
			end
		end
		--for both damage and debuff spell
		if mediCase == 'a'then
			if tonumber(mq.TLO.Me.CurrentMana()) == (tonumber(mq.Spell[dmgSpell].Mana())+tonumber(mq.Spell[debuffSpell].Mana())) then
			medCon =false
			end
		end
	end
 --Loop ended, get back to work
  mq.cmd("/Stand")
  mq.cmd("/Stick unpause")
end

-- Function to keep healer meditating when nothing is happening
-- and is not too far away from tank
function MediLoop(tank)
--Sit
  mq.cmd("/stick pause")
  mq.cmd("/sit")

  medCon = true
  while medCon do
--Go through each member
	for groupMem = 1,tonumber(mq.TLO.Group()),1 do
		--Cycle targeting
		target(groupMem)
    -- Who needs to be healed
    if tonumber(mq.TLO.Target.PctHPs()) < 99 and tonumber(mq.TLO.Target.Distance()) < 30 then
	Heal()
      medCon = false
    end

    --  tank needs a buff
    if mq.TLO.Target.Buff(buffSpell).ID() == nil and tonumber(mq.TLO.Target.Distance()) < 30 then
	Buff()
      medCon = false
    end

    -- too far from tank
    if tonumber(mq.TLO.Target.Distance()) > 30 and groupMem == tank then
      medCon = false
    end
	end
  end

  -- move
  mq.cmd("/stand")
  mq.cmd("/stick unpause")
end

function target(targetIndex)
  mq.cmdf('/target ${Group.Member[%d].CleanName}', targetIndex)
end

function Assist(i)
  ManaCheck('a')
  --Move pause
  mq.cmd("/Stick pause")
  --Target Tank's target
  mq.cmd("/assist")
  --Check for debuff already applied
  if not mq.TLO.Target.Buff(debuffSpell).ID() then
  --Debuff Cast
    mq.cmd("/cast 3")
    mq.delay("6s")
  end
  --Damage spell cast
  mq.cmd("/cast 4")
  mq.delay("6s")
  --Retarget tank
   target(i)
  --Move unpasue
  mq.cmd("/Stick unpause")
end

main()
