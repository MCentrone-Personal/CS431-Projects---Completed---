
sub CARD_GENERATOR {
  return int(rand(51)) + 1;
}

sub POKER_LOGIC {

# This is how Perl gets sent arugements, an array of $_[i]
# Function call PokerLogic(int,int,int,int,int);
#Will return a number, Highcard only will be a 1, Royal flush will be a 10

#Sort from Lowest to Highest, Card 1 lowest ... Card 5 Highest
my @numeric = sort { $a <=> $b } ($_[0], $_[1], $_[2], $_[3], $_[4]);
@CardCounter(0,0,0,0,0,0,0,0,0,0,0,0,0);

$Card1 = $numeric[0];
$Card2 = $numeric[1];
$Card3 = $numeric[2];
$Card4 = $numeric[3];
$Card5 = $numeric[4];

$Flush = 0;
$RoyalFlush = 0;
$StraightFlush = 0;
$FourKind = 0;
$FullHouse = 0;
$Straight = 0;
$ThreeKind = 0;
$TwoPair = 0;
$OnePair = 0;
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
	#Royal Flush
	if((($Card1 % 13) + ($Card2 % 13) + ($Card3 % 13) + ($Card4 % 13) + ($Card5 % 13)) == 34)
	{
	$RoyalFlush = 1;
	}

	#Straightflush
	if((($Card1 + 1) == $Card2) and (($Card1 + 2) == $Card3) and (($Card1 + 3) == $Card4) and (($Card1 + 4) == $Card5))
	{
	$StraightFlush = 1;
	}

}

#Checking for Pairs, Triplets, Full House, ect.

$CardCounter[$Card1 % 13]++;
$CardCounter[$Card2 % 13]++;
$CardCounter[$Card3 % 13]++;
$CardCounter[$Card4 % 13]++;
$CardCounter[$Card5 % 13]++;

$PairsCounted = 0;

for($i = 0; i <13; i++)
{
#Checking for 4 of a kind
	if($CardCounter[i] == 4)
	{
	$FourKind = 1;
	}

#Checking for 3 of a kind
	if(CardCounter[i] == 3)
	{
	$ThreeKind = 1;
	}
	
#Checking for pairs
	if(CardCounter[i] == 2)
	{
	$OnePair = 1;
	$PairsCounted++;
	}
}

#Full House check
if($ThreeKind and $OnePair)
{
$FullHouse = 1;
$ThreeKind = 0;
$OnePair = 0;
}

#Two Pairs Check
if($PairsCounted == 2)
{
$OnePair = 0;
$TwoPair = 1;
}

#Final Return Checks


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
