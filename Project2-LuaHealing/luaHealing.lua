local mq = require('mq')
local PackageMan = require('mq/PackageMan')
local lfs = PackageMan.Require('luafilesystem', 'lfs')

healingSpell = "Healing"
buffSpell = "Holy Armor"

function main()
  tankName = ""
  dpsName = ""

  tankPos = 0
  dpsPos = 0

  if mq.Group < 2 then
    print("You need at least 2 group members")
    return
  end

  tankFound = false
  dpsFound = false

  for i = 1, mq.TLO.Group, +1 do
    mq.cmd('/target ${Group.Member[%d].CleanName}', i)
    s = mq.TLO.Target.Class()

    if (s.TLO.Equal("Shadow Knight") or s.TLO.Equal("Paladin") or s.TLO.Equal("Warrior")) then
      tankFound = true
      tankPos = i
    end

    ---if s.Equal(<Name of DPS) then
      ---dpsFound = true
      ---dpsPos = i
    ---end
  end

  if tankFound = true then
    print("A tank was found.")
  else
    print("No tank found. Exiting...")
    return
  end

  if dpsFound = true then
    print("A DPS was found.")
  ---else
    ---print("No DPS found. Exiting...")
    ---return
  end

  memSpells(healingSpell, buffSpell)

  x = 0
  while x == 0 do

  end
end

function memSpells(healingSpell, buffSpell)
  mq.cmd("/memspell 1 " .. healingSpell)
  print("Delaying 14 seconds to memorize " .. healingSpell)
  mq.cmd("/delay 14s")

  mq.cmd("/memspell 2 " .. buffSpell)
  print("Delaying 14 seconds to memorize " .. buffSpell)
  mq.cmd("/delay 14s")

  print("Support is ready")
end

main()
