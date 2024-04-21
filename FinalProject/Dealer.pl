
our @Results = ();
our @Currenthand = ();
our @Newhand = ();
our $Flag1 = 0;
our $Flag2 = 0;
our $Flag3 = 0;
our $Flag4 = 0;
our $Flag5 = 0;
our $Card1F = "";
our $Card2F = "";
our $Card3F = "";
our $Card4F = "";
our $Card5F = "";
our $UICard1 = "";
our $UICard2 = "";
our $UICard3 = "";
our $UICard4 = "";
our $UICard5 = "";
our $PHigh = 0;
our $DHigh = 0;
our $PFour = 0;
our $DFour = 0;
our $PThree = 0;
our $DThree = 0;
our $POne = 0;
our $DOne = 0;
our $PTwo = 0;
our $DTwo = 0;

sub POKER_START {
	#Function to generate 5 random cards from one deck
	@TempCards = (0,0,0,0,0);
	@CurrentCards = (0,0,0,0,0);
	if($_[0] != 1)
	{
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
	}
	
	if($_[0] == 1)
	{
		if($Flag1 == 1)
		{
			TRYAGAIN1:
		$TempCards[0] = ((int rand(51)) + 1);
		
		if(($TempCards[0] == $_[1]) or ($TempCards[0] == $_[2]) or ($TempCards[0] == $_[3]) or ($TempCards[0] == $_[4]) or ($TempCards[0] == $_[5]))
		{
			goto TRYAGAIN1;
		}
		$CurrentCards[0] = $TempCards[0];
		}
		if($Flag1 == 0)
		{
		$CurrentCards[0] = $_[1];
		}
		
		if($Flag2 == 1)
		{
			TRYAGAIN2:
		$TempCards[1] = ((int rand(51)) + 1);
		
		if(($TempCards[1] == $_[1]) or ($TempCards[1] == $_[2]) or ($TempCards[1] == $_[3]) or ($TempCards[1] == $_[4]) or ($TempCards[1] == $_[5]))
		{
			goto TRYAGAIN2;
		}
		$CurrentCards[1] = $TempCards[1];
		}
		if($Flag2 == 0)
		{
		$CurrentCards[1] = $_[2];
		}
		
		if($Flag3 == 1)
		{
			TRYAGAIN3:
		$TempCards[2] = ((int rand(51)) + 1);
		
		if(($TempCards[2] == $_[1]) or ($TempCards[2] == $_[2]) or ($TempCards[2] == $_[3]) or ($TempCards[2] == $_[4]) or ($TempCards[2] == $_[5]))
		{
			goto TRYAGAIN3;
		}
		$CurrentCards[2] = $TempCards[2];
		}
		if($Flag3 == 0)
		{
		$CurrentCards[2] = $_[3];
		}
		
		if($Flag4 == 1)
		{
			TRYAGAIN4:
		$TempCards[3] = ((int rand(51)) + 1);
		
		if(($TempCards[3] == $_[1]) or ($TempCards[3] == $_[2]) or ($TempCards[3] == $_[3]) or ($TempCards[3] == $_[4]) or ($TempCards[3] == $_[5]))
		{
			goto TRYAGAIN4;
		}
		$CurrentCards[3] = $TempCards[3];
		}
		if($Flag4 == 0)
		{
		$CurrentCards[3] = $_[4];
		}
		
		if($Flag5 == 1)
		{
			TRYAGAIN5:
		$TempCards[4] = ((int rand(51)) + 1);
		
		if(($TempCards[4] == $_[1]) or ($TempCards[4] == $_[2]) or ($TempCards[4] == $_[3]) or ($TempCards[4] == $_[4]) or ($TempCards[4] == $_[5]))
		{
			goto TRYAGAIN5;
		}
		$CurrentCards[4] = $TempCards[4];
		}
		if($Flag5 == 0)
		{
		$CurrentCards[4] = $_[5];
		}
		
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

	if($_[5] == 0)
	{
		$PHigh = ($Card5 % 13);
	}
	if($_[5] == 1)
	{
		$DHigh = ($Card5 % 13);
	}

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
	if($_[5] == 0)
	{
		$PFour = $q;
	}
	if($_[5] == 1)
	{
		$DFour = $q;
	}
	}

#Checking for 3 of a kind
	if($CardCounter[$q] == 3)
	{
	$ThreeKind = 1;
	
	if($_[5] == 0)
	{
		$PThree = $q;
	}
	if($_[5] == 1)
	{
		$DThree = $q;
	}
	}
	
#Checking for pairs
	if($CardCounter[$q] == 2)
	{
	$OnePair = 1;
	$PairsCounted++;
	if($_[5] == 0)
	{
		if($PairsCounted == 0)
		{
		$POne = $q;
		}
		else
		{
		$PTwo = $q;
		}
	}
	if($_[5] == 1)
	{
		if($PairsCounted == 0)
		{
		$DOne = $q;
		}
		else
		{
		$DTwo = $q;
		}
	}
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
return(10,$_[0], $_[1], $_[2], $_[3], $_[4], "Royal Flush");
}
elsif($StraightFlush)
{
return(9,$_[0], $_[1], $_[2], $_[3], $_[4], "Straight Flush");
}
elsif($FourKind)
{
return(8,$_[0], $_[1], $_[2], $_[3], $_[4], "Four of a Kind");
}
elsif($FullHouse)
{
return(7,$_[0], $_[1], $_[2], $_[3], $_[4], "Full House");
}
elsif($Flush)
{
return(6,$_[0], $_[1], $_[2], $_[3], $_[4], "Flush");
}
elsif($Straight)
{
return (5,$_[0], $_[1], $_[2], $_[3], $_[4], "Straight");
}
elsif($ThreeKind)
{
return(4,$_[0], $_[1], $_[2], $_[3], $_[4], "Three of a Kind");
}
elsif($TwoPair)
{
return(3,$_[0], $_[1], $_[2], $_[3], $_[4], "Two Pair");
}
elsif($OnePair)
{
return (2,$_[0], $_[1], $_[2], $_[3], $_[4], "One Pair");
}
elsif($HighCard)
{
return (1,$_[0], $_[1], $_[2], $_[3], $_[4], "High Card");
}

}

sub CMPNUM
{
	if($_[0] > $_[1])
	{
		return("Player Wins by ");
	}
	if($_[0] < $_[1])
	{
		return("Dealer Wins by ");
	}
	if($_[0] == $_[1])
	{
		return("Tie with ");
	}
}

sub POKER_DEALER_V_PLAYER{
	
	if($_[0] > $_[1])
	{
		return("Player Wins by ". $_[2]);
	}
	if($_[0] < $_[1])
	{
		return("Dealer Wins by ". $_[3]);
	}
	if($_[0] == $_[1])
	{
		if($_[2] == "Royal Flush")
		{
		return("Tie");
		}
		if($_[2] == "Straight Flush")
		{
			return(CMPNUM($PHigh,$DHigh) . "Higher Cards");
		}
		if($_[2] == "Four of a Kind")
		{
			return(CMPNUM($PFour,$DFour) . "Higher Cards");
		}
		if($_[2] == "Full House")
		{
			return(CMPNUM($PThree,$DThree) . "Higher Cards");
		}
		if($_[2] == "Flush")
		{
			return(CMPNUM($PHigh,$DHigh) . "Higher Cards");
		}
		if($_[2] == "Striaght")
		{
			return(CMPNUM($PHigh,$DHigh) . "Higher Cards");
		}
		if($_[2] == "Three of a Kind")
		{
			return(CMPNUM($PThree,$DThree) . "Higher Cards");
		}
		if($_[2] == "Two Pair")
		{
			return(CMPNUM($PTwo,$DTwo) . "Higher Cards");
		}
		if($_[2] == "One Pair")
		{
			return(CMPNUM($PPOne,$DPOne) . "Higher Cards");
		}
		if($_[2] == "High Card")
		{
			return(CMPNUM($PHigh,$DHigh) . "Higher Cards");
		}
	}
	
	
}

sub POKER_CARD_NAMES{
	
	@Names = ('Ace of Hearts', 'Two of Hearts', 'Three of Hearts', 'Four of Hearts', 'Five of Hearts', 'Six of Hearts', 'Seven of Hearts', 'Eight of Hearts', 'Nine of Hearts', 'Ten of Hearts', 'Jack of Hearts', 'Queen of Hearts', 'King of Hearts','Ace of Clubs', 'Two of Clubs', 'Three of Clubs', 'Four of Clubs', 'Five of Clubs', 'Six of Clubs', 'Seven of Clubs', 'Eight of Clubs', 'Nine of Clubs', 'Ten of Clubs', 'Jack of Clubs', 'Queen of Clubs', 'King of Clubs', 'Ace of Diamonds', 'Two of Diamonds', 'Three of Diamonds', 'Four of Diamonds', 'Five of Diamonds', 'Six of Diamondss', 'Seven of Diamonds', 'Eight of Diamonds', 'Nine of Diamonds', 'Ten of Diamonds', 'Jack of Diamonds', 'Queen of Diamonds', 'King of Diamonds','Ace of Spades', 'Two of Spades', 'Three of Spades', 'Four of Spades', 'Five of Spades', 'Six of Spades', 'Seven of Spades', 'Eight of Spades', 'Nine of Spades', 'Ten of Spades', 'Jack of Spades', 'Queen of Spades', 'King of Spades');
	
	return($Names[$_[0] - 1]);
	
}
# Message event for NPC, right now responds to hail
sub EVENT_SAY {
    #:: Match say message for "hail", /i for case insensitive
	
    if ($text=~/hail/i)
    {
     quest::say("Hello, $name!. Give me your [money]");
	 @Currenthand = (0,0,0,0,0);
	 $Count = 0;
    }
     if ($text=~/money/i)
    {
		
		
	@Currenthand = (POKER_START(2,0,0,0,0,0));
	
	@Results = (POKER_LOGIC($Currenthand[0],$Currenthand[1],$Currenthand[2],$Currenthand[3],$Currenthand[4]));
	
	$Card1F = POKER_CARD_NAMES($Results[1]);
	$Card2F = POKER_CARD_NAMES($Results[2]);
	$Card3F = POKER_CARD_NAMES($Results[3]);
	$Card4F = POKER_CARD_NAMES($Results[4]);
	$Card5F = POKER_CARD_NAMES($Results[5]);
	
    quest::say("I like money ");
	quest::say($Results[0].', '."[$Card1F]".', '."[$Card2F]".', '."[$Card3F]".', '."[$Card4F]".', '."[$Card5F]");
	
	 my $intro = "Current Hand Power: ". $Results[0]. ". Hand Type: ". $Results[6];
	 my $TextToCenter2 = plugin::PWAutoCenter($Card1F);
	 my $TextToCenter3 = plugin::PWAutoCenter($Card2F);
	 my $TextToCenter4 = plugin::PWAutoCenter($Card3F);
	 my $TextToCenter5 = plugin::PWAutoCenter($Card4F);
	 my $TextToCenter6 = plugin::PWAutoCenter($Card5F);

	 my $Indent = plugin::PWIndent();
	 my $Yel = plugin::PWColor("Yellow");
	 my $Blu = plugin::PWColor("Light Blue");
	 my $Red = plugin::PWColor("Red");
	 my $grn = plugin::PWColor("Forest Green");
	 
	 $UICard1 = $Yel . $TextToCenter2;
	 $UICard2 = $Yel . $TextToCenter3;
	 $UICard3 = $Yel . $TextToCenter4;
	 $UICard4 = $Yel . $TextToCenter5;
	 $UICard5 = $Yel . $TextToCenter6;
	 
	  my $dialogMessage = "{title: Curernt Hand} {button_one: Confirm Hand} {button_two: Start Swapping} wintype:1 $intro </c> <br><br> $Yel $TextToCenter2 </c><br><br> $Yel $TextToCenter3 </c><br><br> $Yel $TextToCenter4 </c><br><br> $Yel $TextToCenter5 </c> <br><br> $Yel $TextToCenter6 </c> <br>";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
		$Count = 0;
		$Flag1 = 0;
		$Flag2 = 0;
		$Flag3 = 0;
		$Flag4 = 0;
		$Flag5 = 0;
	
    }
	
	if ($text=~/Start Swapping/i)
	{
		$Count = 0;
		$Flag1 = 0;
		$Flag2 = 0;
		$Flag3 = 0;
		$Flag4 = 0;
		$Flag5 = 0;
		
		my $dialogMessage = "{title: $Card1F} {button_one: Keep Card} {button_two: Swap} wintype:1 $intro </c> <br><br> $Red $TextToCenter2 </c><br><br> $Yel $TextToCenter3 </c><br><br> $Yel $TextToCenter4 </c><br><br> $Yel $TextToCenter5 </c> <br><br> $Yel $TextToCenter6 </c> <br>";
		quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
	
	if ($text=~/Swap/i)
	{
		my $intro = "Current Hand Power: ". $Results[0]. ". Hand Type: ". $Results[6];
	 my $TextToCenter2 = plugin::PWAutoCenter($Card1F);
	 my $TextToCenter3 = plugin::PWAutoCenter($Card2F);
	 my $TextToCenter4 = plugin::PWAutoCenter($Card3F);
	 my $TextToCenter5 = plugin::PWAutoCenter($Card4F);
	 my $TextToCenter6 = plugin::PWAutoCenter($Card5F);

	 my $Indent = plugin::PWIndent();
	 my $Yel = plugin::PWColor("Yellow");
	 my $Blu = plugin::PWColor("Light Blue");
	 my $Red = plugin::PWColor("Red");
	 my $grn = plugin::PWColor("Forest Green");
	 
		
		if($Count == 0)
		{
			my $dialogMessage = "{title: $Card1F} {button_one: Keep Card} {button_two: Swap} wintype:1 $intro </c> <br><br> $Red $TextToCenter2 </c><br><br> $Yel $TextToCenter3 </c><br><br> $Yel $TextToCenter4 </c><br><br> $Yel $TextToCenter5 </c> <br><br> $Yel $TextToCenter6 </c> <br>";
		quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
		$Count++;
		}
		elsif($Count == 1)
		{
			$Flag1 = 1;
			$UICard1 = $Blu . $TextToCenter2;
			
			my $dialogMessage = "{title: $Card2F} {button_one: Keep Card} {button_two: Swap} wintype:1 $intro </c> <br><br> $UICard1 </c><br><br> $Red $TextToCenter3 </c><br><br> $Yel $TextToCenter4 </c><br><br> $Yel $TextToCenter5 </c> <br><br> $Yel $TextToCenter6 </c> <br>";
		quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
		$Count++;
		}
	elsif($Count == 2)
		{
			$Flag2 = 1;
			$UICard2 = $Blu . $TextToCenter3;
			
			my $dialogMessage = "{title: $Card3F} {button_one: Keep Card} {button_two: Swap} wintype:1 $intro </c> <br><br> $UICard1 </c><br><br> $UICard2 </c><br><br> $Red $TextToCenter4 </c><br><br> $Yel $TextToCenter5 </c> <br><br> $Yel $TextToCenter6 </c> <br>";
		quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
		$Count++;
		}
		elsif($Count == 3)
		{
			$Flag3 = 1;
			$UICard3 = $Blu . $TextToCenter4;
			my $dialogMessage = "{title: $Card4F} {button_one: Keep Card} {button_two: Swap} wintype:1 $intro </c> <br><br> $UICard1 </c><br><br> $UICard2 </c><br><br> $UICard3 </c><br><br> $Red $TextToCenter5 </c> <br><br> $Yel $TextToCenter6 </c> <br>";
		quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
		$Count++;
		}
		elsif($Count == 4)
		{
			$Flag4 = 1;
			$UICard4 = $Blu . $TextToCenter5;
			my $dialogMessage = "{title: $Card5F} {button_one: Keep Card} {button_two: Swap} wintype:1 $intro </c> <br><br> $UICard1 </c><br><br> $UICard2 </c><br><br> $UICard3 </c><br><br> $UICard4 </c> <br><br> $Red $TextToCenter6 </c> <br>";
		quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
		$Count++;
		}
		elsif($Count == 5)
		{
			$Flag5 = 1;
			$UICard5 = $Blu . $TextToCenter6;
			my $dialogMessage = "{title: Final Hand} {button_one: Restart} {button_two: Confirm Hand} wintype:1 $intro </c> <br><br> $UICard1 </c><br><br> $UICard2 </c><br><br> $UICard3 </c><br><br> $UICard4 </c> <br><br> $UICard5 </c> <br>";
		quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
		
		}
	}
	
	if ($text=~/Restart/i)
	{
		$Count = 0;
		$Flag1 =0;
		$Flag2 =0;
		$Flag3 =0;
		$Flag4 =0;
		$Flag5 =0;
		
		 my $intro = "Current Hand Power: ". $Results[0]. ". Hand Type: ". $Results[6];
	 my $TextToCenter2 = plugin::PWAutoCenter($Card1F);
	 my $TextToCenter3 = plugin::PWAutoCenter($Card2F);
	 my $TextToCenter4 = plugin::PWAutoCenter($Card3F);
	 my $TextToCenter5 = plugin::PWAutoCenter($Card4F);
	 my $TextToCenter6 = plugin::PWAutoCenter($Card5F);

	 my $Indent = plugin::PWIndent();
	 my $Yel = plugin::PWColor("Yellow");
	 my $Blu = plugin::PWColor("Light Blue");
	 my $Red = plugin::PWColor("Red");
	 my $grn = plugin::PWColor("Forest Green");
	 
	 $UICard1 = $Yel . $TextToCenter2;
	 $UICard2 = $Yel . $TextToCenter3;
	 $UICard3 = $Yel . $TextToCenter4;
	 $UICard4 = $Yel . $TextToCenter5;
	 $UICard5 = $Yel . $TextToCenter6;
	 
	  my $dialogMessage = "{title: Curernt Hand} {button_one: Confirm Hand} {button_two: Start Swapping} wintype:1 $intro </c> <br><br> $Yel $TextToCenter2 </c><br><br> $Yel $TextToCenter3 </c><br><br> $Yel $TextToCenter4 </c><br><br> $Yel $TextToCenter5 </c> <br><br> $Yel $TextToCenter6 </c> <br>";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
		
	}
	
	if ($text=~/Keep Card/i)
	{
		
		my $intro = "Current Hand Power: ". $Results[0]. ". Hand Type: ". $Results[6];
	 my $TextToCenter2 = plugin::PWAutoCenter($Card1F);
	 my $TextToCenter3 = plugin::PWAutoCenter($Card2F);
	 my $TextToCenter4 = plugin::PWAutoCenter($Card3F);
	 my $TextToCenter5 = plugin::PWAutoCenter($Card4F);
	 my $TextToCenter6 = plugin::PWAutoCenter($Card5F);

	 my $Indent = plugin::PWIndent();
	 my $Yel = plugin::PWColor("Yellow");
	 my $Blu = plugin::PWColor("Light Blue");
	 my $Red = plugin::PWColor("Red");
	 my $grn = plugin::PWColor("Forest Green");
	 
		if($Count == 0)
		{
			$Flag1 = 0;
			
			my $dialogMessage = "{title: $Card1F} {button_one: Keep Card} {button_two: Swap} wintype:1 $intro </c> <br><br> $Yel $TextToCenter2 </c><br><br> $Red $TextToCenter3 </c><br><br> $Yel $TextToCenter4 </c><br><br> $Yel $TextToCenter5 </c> <br><br> $Yel $TextToCenter6 </c> <br>";
		quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
		$Count++;
		}
		elsif($Count == 1)
		{
			$Flag1 = 0;
			my $dialogMessage = "{title: $Card2F} {button_one: Keep Card} {button_two: Swap} wintype:1 $intro </c> <br><br> $UICard1 </c><br><br> $Red $TextToCenter3 </c><br><br> $Yel $TextToCenter4 </c><br><br> $Yel $TextToCenter5 </c> <br><br> $Yel $TextToCenter6 </c> <br>";
		quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
		$Count++;
		}
	elsif($Count == 2)
		{
			$Flag2 = 0;
			my $dialogMessage = "{title: $Card3F} {button_one: Keep Card} {button_two: Swap} wintype:1 $intro </c> <br><br> $UICard1 </c><br><br> $UICard2 </c><br><br> $Red $TextToCenter4 </c><br><br> $Yel $TextToCenter5 </c> <br><br> $Yel $TextToCenter6 </c> <br>";
		quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
		$Count++;
		}
		elsif($Count == 3)
		{
			$Flag3 = 0;
			my $dialogMessage = "{title: $Card4F} {button_one: Keep Card} {button_two: Swap} wintype:1 $intro </c> <br><br> $UICard1 </c><br><br> $UICard2 </c><br><br> $UICard3</c><br><br> $Red $TextToCenter5 </c> <br><br> $Yel $TextToCenter6 </c> <br>";
		quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
		$Count++;
		}
		elsif($Count == 4)
		{
			$Flag4 = 0;
			my $dialogMessage = "{title: $Card4F} {button_one: Keep Card} {button_two: Swap} wintype:1 $intro </c> <br><br> $UICard1 </c><br><br> $UICard2 </c><br><br> $UICard3 </c><br><br> $UICard4 </c> <br><br> $Red $TextToCenter6 </c> <br>";
		quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
		$Count++;
		}
		elsif($Count == 5)
		{
			$Flag5 = 0;
			my $dialogMessage = "{title: Final Hand} {button_one: Restart} {button_two: Confirm Hand} wintype:1 $intro </c> <br><br> $UICard1 </c><br><br> $UICard2 </c><br><br> $UICard3 </c><br><br> $UICard4 </c> <br><br> $UICard5 </c> <br>";
		quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
		}
	}
	
	
	if ($text=~/Confirm Hand/i)
     {
		 
    @Newhand = (POKER_START(1,$Currenthand[0],$Currenthand[1],$Currenthand[2],$Currenthand[3],$Currenthand[4]));
	
	@NewResults = (POKER_LOGIC($Newhand[0],$Newhand[1],$Newhand[2],$Newhand[3],$Newhand[4],0));
	
	$Card1F = POKER_CARD_NAMES($NewResults[1]);
	$Card2F = POKER_CARD_NAMES($NewResults[2]);
	$Card3F = POKER_CARD_NAMES($NewResults[3]);
	$Card4F = POKER_CARD_NAMES($NewResults[4]);
	$Card5F = POKER_CARD_NAMES($NewResults[5]);
	
	
	
	my $intro = "Current Hand Power: ". $NewResults[0]. ". Hand Type: ". $NewResults[6];
	 my $TextToCenter2 = plugin::PWAutoCenter($Card1F);
	 my $TextToCenter3 = plugin::PWAutoCenter($Card2F);
	 my $TextToCenter4 = plugin::PWAutoCenter($Card3F);
	 my $TextToCenter5 = plugin::PWAutoCenter($Card4F);
	 my $TextToCenter6 = plugin::PWAutoCenter($Card5F);

	 my $Indent = plugin::PWIndent();
	 my $Yel = plugin::PWColor("Yellow");
	 my $Blu = plugin::PWColor("Light Blue");
	 my $Red = plugin::PWColor("Red");
	 my $grn = plugin::PWColor("Forest Green");
	
	 quest::popup("Results", "$intro </c> <br><br> $Yel $TextToCenter2 </c><br><br> $Yel $TextToCenter3 </c><br><br> $Yel $TextToCenter4 </c><br><br> $Yel $TextToCenter5 </c> <br><br> $Yel $TextToCenter6");
	 
	 @DealerHand = (POKER_START(0,0,0,0,0,0));
	 
	 @DealerResults = (POKER_LOGIC($DealerHand[0],$DealerHand[1],$DealerHand[2],$DealerHand[3],$DealerHand[4],1));
	 
	 $Card1FD = POKER_CARD_NAMES($DealerResults[1]);
	$Card2FD = POKER_CARD_NAMES($DealerResults[2]);
	$Card3FD = POKER_CARD_NAMES($DealerResults[3]);
	$Card4FD = POKER_CARD_NAMES($DealerResults[4]);
	$Card5FD = POKER_CARD_NAMES($DealerResults[5]);
	
	 $Outcome = POKER_DEALER_V_PLAYER($NewResults[0], $DealerResults[0],$NewResults[6],$DealerResults[6]);
	
	quest::say($NewResults[0].', '."[$Card1F]".', '."[$Card2F]".', '."[$Card3F]".', '."[$Card4F]".', '."[$Card5F]");
	quest::say($DealerResults[0].', '."[$Card1FD]".', '."[$Card2FD]".', '."[$Card3FD]".', '."[$Card4FD]".', '."[$Card5FD]");
	quest::say($Outcome);
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
