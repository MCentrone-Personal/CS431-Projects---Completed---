# Event when npc spawns
sub EVENT_SPAWN {
    #:: Create a proximity, 100 units across, 100 units tall, enable proximity say
    quest::set_proximity($x - 50, $x + 50, $y - 50, $y + 50, $z - 50, $z + 50, 1);
    #:: Also, enable proximity say
    quest::enable_proximity_say();
}

# Message event for NPC, right now responds to hail
sub EVENT_SAY {
   # Prevent pets or charmed NPCs from using the default.pl
   if (!$npc || $npc->GetOwnerID() || $npc->GetSwarmOwner())
   {
      return;
   }
   if ($text=~/hail/i) {
    quest::say("Shh , Im going to kill you.");
   }
}
