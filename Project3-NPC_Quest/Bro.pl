# Event when npc spawns
sub EVENT_SPAWN {
    #:: Create a proximity, 100 units across, 100 units tall, enable proximity say
    quest::set_proximity($x - 50, $x + 50, $y - 50, $y + 50, $z - 50, $z + 50, 1);
    #:: Also, enable proximity say
    quest::enable_proximity_say();
}
$item;
@spell = (278,19421);
# Message event for NPC, right now responds to hail
sub EVENT_SAY {
    #:: Match say message for "hail", /i for case insensitive
    if ($text=~/hail/i)
    {
        quest::say("Hello, $name!. I NEED [SHROOMS]. In return i can help you get an [item].");
		quest::say("By any chance do you need a [buff] or [healing]");
		quest::say("Finally i can offer up a little [trade]");
		quest::say("if you have nothing left to do [begone]");
	}
	if($text=~/buff/i)
	{
		$npc->CastSpell(@spell[0], $userid);
	}
	if($text=~/healing/i)
	{
		$npc->CastSpell(@spell[1], $userid);
	}
	if($text=~/begone/i)
	{
		$npc->CastSpell(2943, $userid);
	}
	if($text=~/trade/i)
	{
		quest::say("Money has no monitary value to me, however if you give me 10,000p i will give you a level");
		quest::say("you also have the option to give me 4,000p and if you are level 52 or higher I will give you alternate advancement points");
	}
	if ($text=~/shrooms/i) 
	{
	quest::popup("Magic Shrooms", "I need the shrooms man. Give me that mushroom right there");
	}

	if($text=~/item/i)
	{
	quest::say("In order for me to summon an item for you I need to know it's ID number. I will remember this item for when you want it");
	}
    if ($text=~/\d{0,9}/)
	{
		$item = $text;
	quest::say("You want item ID:$text");
	}


}

sub EVENT_ITEM {
	
	my $total = ($platinum * 1000) + ($gold * 100) + ($silver * 10) + $copper;
	
	#Purchase level
	if($total >= 10000)
	{
		quest::level($ulevel+1);
		$total -= 10000;
	}
	
	#purchase alternate advancement points 
	if($total >= 4000 && $total < 10000 && $ulevel >=52)
	{
		$client->AddAAPoints(1);
		$total -= 4000;
	}
	
	
	#return any unused money
	if($total > 0)
	{
	    my $copper_return = $total % 10;
		$total = (($total - $copper_return)/10);
		my $silver_return= $total % 10;
		$total = (($total - $silver_return)/10);
		my $gold_return = $total % 10;
		$total = (($total - $gold_return)/10);
		quest::givecash($copper_return,$silver_return,$gold_return,$total);
	}

	
  if (plugin::check_handin(\%itemcount, 59955 => 1)) 
  {  
    quest::summonitem(10037);
	quest::givecash(5,5,5,5);
    quest::ding();
	quest::say("Thanks! This item can help you in the future!");
  }
  
  elsif(plugin::check_handin(\%itemcount, 10037 => 1)) 
  {  
	quest::say("Thanks! Now to give you item $item");
	quest::summonitem("$item");
  }  
  
  plugin::return_items(\%itemcount);
}