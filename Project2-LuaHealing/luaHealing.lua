--Things Lua needs to use for MacroQuest
local mq = require('mq')
local PackageMan = require('mq/PackageMan')
--local lfs = PackageMan.Require('luafilesystem', 'lfs')

--Spells for the healer macro
healingSpell = "Healing"
buffSpell = "Holy Armor"
debuffSpell = ""
dmgSpell = ""

--Main Function
function main()
  tankName = ""
  dpsName = ""

  --Position of the tank and dps
  tankPos = 0
  dpsPos = 0

  --Checking group has enough members
  if tonumber(mq.TLO.Group()) < 2 then
    print("You need at least 2 group members")
    return
  end

  --Bools if tank / dps in group
  tankFound = false
  dpsFound = false

  --Checking for Tank and DPS
  for i = 1, mq.Group, i+1 do
    mq.cmd('/target ${Group.Member[%d].CleanName}', i)
    s = mq.Target.Class()

    if (s.Equal("Shadow Knight") or s.Equal("Paladin") or s.Equal("Warrior")) then
      tankFound = true
      tankPos = i
    end

    ---if s.Equal(<Name of DPS) then
      ---dpsFound = true
      ---dpsPos = i
    ---end
  end

  --Tank was found?
  if tankFound == true then
    print("A tank was found.")
  else
    print("No tank found. Exiting...")
    return
  end
--DPS was found?
  if dpsFound == true then
    print("A DPS was found.")
  ---else
    ---print("No DPS found. Exiting...")
    ---return
  end
  
  --Previous conditions true
  --Memorize spells
  memSpells(healingSpell, buffSpell, debuffSpell, dmgSpell)

  --Movement
  mq.cmd("/stick helaer")

  --Forever loop
  x = 0
  while x == 0 do
 HpCheck()
  end

end
  
--Memorizing spells
function memSpells(healingSpell, buffSpell, debuffSpell, dmgSpell)
    --Healing spell
  mq.cmd("/memspell 1 " .. healingSpell)
  print("Delaying 14 seconds to memorize " .. healingSpell)
  mq.cmd("/delay 14s")
    --Buff Spell
  mq.cmd("/memspell 2 " .. buffSpell)
  print("Delaying 14 seconds to memorize " .. buffSpell)
  mq.cmd("/delay 14s")
    --Debuff Spell
  mq.cmd("/memspell 3 " .. debuffSpell)
  print("Delaying 14 seconds to memorize " .. healingSpell)
  mq.cmd("/delay 14s")
    --Damage Spell
  mq.cmd("/memspell 4 " .. dmgSpell)
  print("Delaying 14 seconds to memorize " .. buffSpell)
  mq.cmd("/delay 14s")
     --Yippieeee
  print("Support is ready")
end

  function HpCheck()
    --Target in Combat
   if  mq.TLO.Target.PctHPs < 99 then
      Heal()
   end
    --Target Chill
    if mq.TLO.Target.PctsHPs == 100 then
      Buff()
      --Target chill and we are in range
      if mq.TLO.Target.Distance < 20 then
        MediLoop()
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
  mq.cmd("/delay 6s")
    --Movement unpaused
  mq.cmd("/Stick unpause")
 end

 function Buff()
    if not mq.TLO.Target.Buff('Holy Amror').ID() then
      --Buff not active
      ManaCheck()
      --Move pause
      mq.cmd("/Stick pause")
      --Casting buff
      mq.cmd("/cast 2")
      --Delay to cast spell
      mq.cmd("/delay 6s")
      --Move unpasue
      mq.cmd("/Stick unpause")
    end
  end

  function ManaCheck()
    if mq.TLO.Me.PctMana < 20 then
      Medi()
    end
    end

  function Medi()
    mq.cmd("/Stick pause")
    mq.cmd("/Sit")
    mq.cmd("/Delay 15s")
    mq.cmd("/Stand")
    mq.cmd("/Stick unpause")
  end

  function MediLoop()
    
  end

main()
