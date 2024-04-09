# Event when npc spawns
sub EVENT_SPAWN {
    #:: Create a proximity, 100 units across, 100 units tall, enable proximity say
    quest::set_proximity($x - 50, $x + 50, $y - 50, $y + 50, $z - 50, $z + 50, 1);
    #:: Also, enable proximity say
    quest::enable_proximity_say();
}
$item;
# Message event for NPC, right now responds to hail
sub EVENT_SAY {
    #:: Match say message for "hail", /i for case insensitive
    	if ($text=~/hail/i)
        {
        quest::say("Hello, $name!. I NEED [SHROOMS]. Or I can give you an [item]. Dont forget to warn [josh] about his [meeting] at 12.");
		quest::say("if you have nothing left to do [begone]");
	    }
	elsif($text=~/josh/i)
	{
		$npc->CastSpell(5408, $userid);
		quest::say("rawr");
	}
	elsif($text=~/meeting/i)
	{
		$npc->CastSpell(19421, $userid);
		quest::say("excuse me");
	}
	elsif($text=~/begone/i)
	{
		$npc->CastSpell(2943, $userid);
		quest::say("bye bye");
	}

	
	elsif ($text=~/shrooms/i) 
	{
	quest::popup("Magic Shrooms", "I need the shrooms man");
	}

	elsif($text=~/item/i)
	{
	quest::say("In order for me to summon an item for you I need to know it's ID number. Please do a #itemsearch itemname and just tell me the number next to the item.");
	}
        elsif ($text=~/\d{0,9}/)
	{
		$item = $text;
	quest::say("You want item $text");
	}


}

sub EVENT_ITEM {
	
  if (plugin::check_handin(\%itemcount, 59955 => 1)) 
  {
    quest::summonitem(10037);
	quest::givecash(10,0,1,200);
    quest::ding();
	quest::say("Thanks! This item can help you in the future!");
    quest::updatetaskactivity(1448, 4);
  }
  elsif(plugin::check_handin(\%itemcount, 10037 => 1)) 
  {
	quest::say("Thanks! Noq to give you item $item");
	quest::summonitem("$item");
    quest::updatetaskactivity(1448, 4);
  }
  plugin::return_items(\%itemcount);
}