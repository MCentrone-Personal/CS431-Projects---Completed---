# Event when npc spawns
sub EVENT_SPAWN {
    #:: Create a proximity, 100 units across, 100 units tall, enable proximity say
    quest::set_proximity($x - 50, $x + 50, $y - 50, $y + 50, $z - 50, $z + 50, 1);
    #:: Also, enable proximity say
    quest::enable_proximity_say();
}

# Message event for NPC, right now responds to hail
sub EVENT_SAY {
    #:: Match say message for "hail", /i for case insensitive
    if ($text=~/hail/i) {
        quest::say("Hello, $name!");
    }
}
