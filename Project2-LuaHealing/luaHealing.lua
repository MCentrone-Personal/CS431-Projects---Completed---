local mq = local name = require('mq')
local PackageMan = require('mq/PackageMan')
local lfs = PackageMan.Require('luafilesystem', 'lfs')

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

  for i = 1, mq.Group, +1 do
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

  if tankFound = true then
    print("A tank was found.")
  else
    print("No tank found. Exiting...")
    return
  end

  if dpsFound = true then
    print("A DPS was found.")
  else
    print("No DPS found. Exiting...")
    return
  end


end

main()
