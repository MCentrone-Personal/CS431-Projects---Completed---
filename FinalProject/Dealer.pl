
sub CARD_GENERATOR {
  return int(rand(51)) + 1;
}

sub POKER_LOGIC {

# This is how Perl gets sent arugements, an array of $_[i]
# Function call PokerLogic(int,int,int,int,int);
#Will return a number, Highcard only will be a 1, Royal flush will be a 10

$Card1 = $_[0];
$Card2 = $_[1];
$Card3 = $_[2];
$Card4 = $_[3];
$Card5 = $_[4];

$Flush = 0;
$RoyalFlush = 0;
$StraightFlush = 0;

$HighCard = 0;

#Flush Check
if ($Card1 >= 40 and $Card2 >= 40 and $Card3 >= 40 and $Card4 >= 40 and $Card5 >= 40)
{
$Flush = 1;
}
else if ($Card1 >= 27 and $Card2 >= 27 and $Card3 >= 27 and $Card4 >= 27 and $Card5 >= 27 and $Card1 < 40 and $Card2 < 40 and $Card3 < 40 and $Card4 < 40 and $Card5 < 40)
{
$Flush = 1;
}
else if ($Card1 >= 14 and $Card2 >= 14 and $Card3 >= 14 and $Card4 >= 14 and $Card5 >= 14 and $Card1 < 27 and $Card2 < 27 and $Card3 < 27 and $Card4 < 27 and $Card5 < 27)
{
$Flush = 1;
}
else if ($Card1 <= 13 and $Card2 <= 13 and $Card3 <=13 and $Card4 <=13 and $Card5 <= 13)
{
$Flush = 1;
}

#Royal Flush Check / Striaght Flush
if($Flush)
{

	if((($Card1 % 13) + ($Card2 % 13) + ($Card3 % 13) + ($Card4 % 13) + ($Card5 % 13)) == 34)
	{
	$RoyalFlush = 2;
	}

}
	if

}
# Message event for NPC, right now responds to hail
sub EVENT_SAY {
    #:: Match say message for "hail", /i for case insensitive
    if ($text=~/hail/i)
    {
     quest::say("Hello, $name!. Give me your [money]");
    }
     if ($text=~/money/i)
    {
     quest::say("I like money");
    }
}

sub EVENT_ITEM {

	my $total = ($platinum * 1000) + ($gold * 100) + ($silver * 10) + $copper;
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
  plugin::return_items(\%itemcount);
}
