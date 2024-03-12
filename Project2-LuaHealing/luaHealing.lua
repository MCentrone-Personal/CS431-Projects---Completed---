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

--Main Function
function main()
  tankName = ""
  dpsName = ""

  --Position of the tank and dps
  tankPos = 0
  dpsPos = 0

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
  target(tankPos)
  memSpells(healingSpell, buffSpell, debuffSpell, dmgSpell)

  --Movement
  mq.cmd("/stick healer")

  --Forever loop
groupMem = 0
  while true do
	   for groupMem = 1,tonumber(mq.TLO.Group()),1 do
		   HpCheck(tankPos,groupMem)
     end
  end

end

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
          MediLoop()
  		  end
      end
    end
  end
end

function Heal()
  --Check Mana
  ManaCheck()
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
    ManaCheck()
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

function ManaCheck()
  if tonumber(mq.TLO.Me.PctMana()) < 20 then
    Medi()
  end
end

function Medi()
  mq.cmd("/Stick pause")
  mq.cmd("/Sit")
  print("Meditating for 15 seconds")
  mq.delay("15s")
  mq.cmd("/Stand")
  mq.cmd("/Stick unpause")
end

-- Function to keep healer meditating when nothing is happening
-- and is not too far away from tank
function MediLoop()
  mq.cmd("/stick pause")
  mq.cmd("/sit")

  medCon = true

  while medCon do

    -- tank needs to be healed
    if tonumber(mq.TLO.Target.PctHPs()) < 99 then
      medCon = false
    end

    --  tank needs a buff
    if mq.TLO.Target.Buff(buffSpell).ID() == nil then
      medCon = false
    end

    -- too far from tank
    if tonumber(mq.TLO.Target.Distance()) > 20 then
      medCon = false
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
  ManaCheck()
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
