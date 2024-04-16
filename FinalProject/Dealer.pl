
sub POKER_START {
	#Function to generate 5 random cards from one deck
	@TempCards = (0,0,0,0,0);
	@CurrentCards = (0,0,0,0,0);
	for($i = 0; $i<5; $i++)
	{
		TRYAGAIN:
		$TempCards[$i] = ((int rand(51)) + 1);
		
		if(($TempCards[$i] == $CurrentCards[0]) or ($TempCards[$i] == $CurrentCards[1]) or ($TempCards[$i] == $CurrentCards[2]) or ($TempCards[$i] == $CurrentCards[3]) or ($TempCards[$i] == $CurrentCards[4]))
		{
			goto TRYAGAIN;
		}
		$CurrentCards[$i] = $TempCards[$i];
	}
  return ($CurrentCards[0],$CurrentCards[1],$CurrentCards[2],$CurrentCards[3],$CurrentCards[4]);
  
}

sub POKER_LOGIC {

# This is how Perl gets sent arugements, an array of $_[i]
# Function call PokerLogic(int,int,int,int,int);
#Will return a number, Highcard only will be a 1, Royal flush will be a 10

@numeric = (int($_[0]), int($_[1]), int($_[2]), int($_[3]), int($_[4]));
#Sort from Lowest to Highest, Card 1 lowest ... Card 5 Highest

@numeric = sort { $a <=> $b } ($_[0], $_[1], $_[2], $_[3], $_[4]);

@CardCounter = (0,0,0,0,0,0,0,0,0,0,0,0,0);


$Card1 = int($numeric[0]);
$Card2 = int($numeric[1]);
$Card3 = int($numeric[2]);
$Card4 = int($numeric[3]);
$Card5 = int($numeric[4]);

$RoyalFlush = 0;
$StraightFlush = 0;
$FourKind = 0;
$FullHouse = 0;
$Flush = 0;
$Straight = 0;
$ThreeKind = 0;
$TwoPair = 0;
$OnePair = 0;
$HighCard = 1;

#Flush Check
if (($Card1 >= 40) and ($Card2 >= 40) and ($Card3 >= 40) and ($Card4 >= 40) and ($Card5 >= 40))
{
$Flush = 1;
}
elsif(($Card1 >= 27) and ($Card2 >= 27) and ($Card3 >= 27) and ($Card4 >= 27) and ($Card5 >= 27) and ($Card1 < 40) and ($Card2 < 40) and ($Card3 < 40) and ($Card4 < 40) and ($Card5 < 40))
{
$Flush = 1;
}
elsif(($Card1 >= 14) and ($Card2 >= 14) and ($Card3 >= 14) and ($Card4 >= 14) and ($Card5 >= 14) and ($Card1 < 27) and ($Card2 < 27) and ($Card3 < 27) and ($Card4 < 27) and ($Card5 < 27))
{
$Flush = 1;
}
elsif (($Card1 <= 13) and ($Card2 <= 13) and ($Card3 <=13) and ($Card4 <=13) and ($Card5 <= 13))
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
	$Flush = 0;
	}

	#Straightflush
	if(((($Card1 % 13) + 1) == ($Card2 % 13)) and ((($Card1 % 13) + 2) == ($Card3 % 13)) and ((($Card1 % 13) + 3) == ($Card4 %13)) and ((($Card1 % 13) + 4) == ($Card5 % 13)))
	{
	$StraightFlush = 1;
	$Flush = 0;
	}

}

#Striaght Check
if($StraightFlush == 0)
{
if(((($Card1 % 13) + 1) == ($Card2 % 13)) and ((($Card1 % 13) + 2) == ($Card3 % 13)) and ((($Card1 % 13) + 3) == ($Card4 %13)) and ((($Card1 % 13) + 4) == ($Card5 % 13)))
	{
	$Straight = 1;
	}
}

#Checking for Pairs, Triplets, Full House, ect.

$CardCounter[$Card1 % 13]++;
$CardCounter[$Card2 % 13]++;
$CardCounter[$Card3 % 13]++;
$CardCounter[$Card4 % 13]++;
$CardCounter[$Card5 % 13]++;

$PairsCounted = 0;

for($q = 0; $q <13; $q++)
{
#Checking for 4 of a kind
	if($CardCounter[$q] == 4)
	{
	$FourKind = 1;
	}

#Checking for 3 of a kind
	if($CardCounter[$q] == 3)
	{
	$ThreeKind = 1;
	}
	
#Checking for pairs
	if($CardCounter[$q] == 2)
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
if($RoyalFlush)
{
return(10,int($Card1),int($Card2),int($Card3),int($Card4),int($Card5));
}
elsif($StraightFlush)
{
return(9,int($Card1),int($Card2),int($Card3),int($Card4),int($Card5));
}
elsif($FourKind)
{
return(8,int($Card1),int($Card2),int($Card3),int($Card4),int($Card5));
}
elsif($FullHouse)
{
return(7,int($Card1),int($Card2),int($Card3),int($Card4),int($Card5));
}
elsif($Flush)
{
return(6,int($Card1),int($Card2),int($Card3),int($Card4),int($Card5));
}
elsif($Straight)
{
return (5,int($Card1),int($Card2),int($Card3),int($Card4),int($Card5));
}
elsif($ThreeKind)
{
return(4,int($Card1),int($Card2),int($Card3),int($Card4),int($Card5));
}
elsif($TwoPair)
{
return(3,int($Card1),int($Card2),int($Card3),int($Card4),int($Card5));
}
elsif($OnePair)
{
return (2,int($Card1),int($Card2),int($Card3),int($Card4),int($Card5));
}
elsif($HighCard)
{
return (1,int($Card1),int($Card2),int($Card3),int($Card4),int($Card5));
}

}

sub POKER_CARD_NAMES{
	
	@Names = ('Ace of Hearts', 'Two of Hearts', 'Three of Hearts', 'Four of Hearts', 'Five of Hearts', 'Six of Hearts', 'Seven of Hearts', 'Eight of Hearts', 'Nine of Hearts', 'Ten of Hearts', 'Jack of Hearts', 'Queen of Hearts', 'King of Hearts','Ace of Clubs', 'Two of Clubs', 'Three of Clubs', 'Four of Clubs', 'Five of Clubs', 'Six of Clubs', 'Seven of Clubs', 'Eight of Clubs', 'Nine of Clubs', 'Ten of Clubs', 'Jack of Clubs', 'Queen of Clubs', 'King of Clubs', 'Ace of Diamonds', 'Two of Diamonds', 'Three of Diamonds', 'Four of Diamondss', 'Five of Diamonds', 'Six of Diamondss', 'Seven of Diamonds', 'Eight of Diamonds', 'Nine of Diamonds', 'Ten of Diamonds', 'Jack of Diamonds', 'Queen of Diamonds', 'King of Diamonds','Ace of Spades', 'Two of Spades', 'Three of Spades', 'Four of Spades', 'Five of Spades', 'Six of Spades', 'Seven of Spades', 'Eight of Spades', 'Nine of Spades', 'Ten of Spades', 'Jack of Spades', 'Queen of Spades', 'King of Spades');
	
	return($Names[$_[0] - 1]);
	
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
		
	@Currenthand = (POKER_START());
	
	@Results = (POKER_LOGIC(int($Currenthand[0]),int($Currenthand[1]),$Currenthand[2],$Currenthand[3],$Currenthand[4]));
	
    quest::say("I like money ");
	quest::say($Results[0].', '.POKER_CARD_NAMES($Results[1]).', '.POKER_CARD_NAMES($Results[2]).', '.POKER_CARD_NAMES($Results[3]).', '.POKER_CARD_NAMES($Results[4]).', '.POKER_CARD_NAMES($Results[5]));
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
