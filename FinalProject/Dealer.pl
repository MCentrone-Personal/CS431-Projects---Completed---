sub POKER_START {
	#Function to generate 5 random cards from one deck
	print "Start of Poker_Start";
	@TempCards = (0,0,0,0,0);
	@CurrentCards = (0,0,0,0,0);
	print "Created arrays";
	for($i = 0; $i<5; $i++)
	{
		print "For loop position $i";
		TRYAGAIN:
		print "random card maker";
		$TempCards[i] = ((int rand(51)) + 1);
		if(($TempCards[i] == $CurrentCards[0]) or ($TempCards[i] == $CurrentCards[1]) or ($TempCards[i] == $CurrentCards[2]) or ($TempCards[i] == $CurrentCards[3]) or ($TempCards[i] == $CurrentCards[4]))
		{
			goto TRYAGAIN;
			print "Card failed";
		}
		print "Assigning cards";
		$CurrentCards[i] = $TempCards[i];
	}
	print "Sending array";
  return (@$CurrentCards);

}

sub POKER_LOGIC {

# This is how Perl gets sent arugements, an array of $_[i]
# Function call PokerLogic(int,int,int,int,int);
#Will return a number, Highcard only will be a 1, Royal flush will be a 10

#Sort from Lowest to Highest, Card 1 lowest ... Card 5 Highest
@numeric = sort($_[0], $_[1], $_[2], $_[3], $_[4]);
print "Created sorted array from cards";
@CardCounter = (0,0,0,0,0,0,0,0,0,0,0,0,0);

$Card1 = $numeric[0];
$Card2 = $numeric[1];
$Card3 = $numeric[2];
$Card4 = $numeric[3];
$Card5 = $numeric[4];

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
print "flush checks";
#Royal Flush Check / Striaght Flush
if($Flush)
{
	print "Flush detected";
	#Royal Flush
	if((($Card1 % 13) + ($Card2 % 13) + ($Card3 % 13) + ($Card4 % 13) + ($Card5 % 13)) == 34)
	{
	$RoyalFlush = 1;
	$Flush = 0;
	}

	#Straightflush
	if((($Card1 + 1) == $Card2) and (($Card1 + 2) == $Card3) and (($Card1 + 3) == $Card4) and (($Card1 + 4) == $Card5))
	{
	$StraightFlush = 1;
	$Flush = 0;
	}

}

#Striaght Check
if($StraightFlush == 0)
{
if((($Card1 + 1) == $Card2) and (($Card1 + 2) == $Card3) and (($Card1 + 3) == $Card4) and (($Card1 + 4) == $Card5))
	{
	$Straight = 1;
	print "Striaght detected";
	}
}

#Checking for Pairs, Triplets, Full House, ect.

$CardCounter[$Card1 % 13]++;
$CardCounter[$Card2 % 13]++;
$CardCounter[$Card3 % 13]++;
$CardCounter[$Card4 % 13]++;
$CardCounter[$Card5 % 13]++;
print "Cards Counted";

$PairsCounted = 0;

for($q = 0; $q <13; $q++)
{
#Checking for 4 of a kind
	if($CardCounter[i] == 4)
	{
	$FourKind = 1;
	}

#Checking for 3 of a kind
	if($CardCounter[i] == 3)
	{
	$ThreeKind = 1;
	}

#Checking for pairs
	if($CardCounter[i] == 2)
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

@ReturnArray = ();

#Final Return Checks
if($RoyalFlush)
{
	@ReturnArray = (10,$Card1,$Card2,$Card3,$Card4,$Card5);
return (@ReturnArray);
}
elsif($StraightFlush)
{
@ReturnArray = (9,$Card1,$Card2,$Card3,$Card4,$Card5);
return (@ReturnArray);
}
elsif($FourKind)
{
@ReturnArray = (8,$Card1,$Card2,$Card3,$Card4,$Card5);
return (@ReturnArray);
}
elsif($FullHouse)
{
@ReturnArray = (7,$Card1,$Card2,$Card3,$Card4,$Card5);
return (@ReturnArray);
}
elsif($Flush)
{
@ReturnArray = (6,$Card1,$Card2,$Card3,$Card4,$Card5);
return (@ReturnArray);
}
elsif($Straight)
{
@ReturnArray = (5,$Card1,$Card2,$Card3,$Card4,$Card5);
return (@ReturnArray);
}
elsif($ThreeKind)
{
@ReturnArray = (4,$Card1,$Card2,$Card3,$Card4,$Card5);
return (@ReturnArray);
}
elsif($TwoPair)
{
@ReturnArray = (3,$Card1,$Card2,$Card3,$Card4,$Card5);
return (@ReturnArray);
}
elsif($OnePair)
{
@ReturnArray = (2,$Card1,$Card2,$Card3,$Card4,$Card5);
return (@ReturnArray);
}
elsif($HighCard)
{
@ReturnArray = (1,$Card1,$Card2,$Card3,$Card4,$Card5);
return (@ReturnArray);
}

}

our @BlackJack_CardsNumList = (1..52);
our @BlackJack_PlayerCardsNum = ();
our @BlackJack_DealerCardsNum = ();
our @BlackJack_PlayerCardsStr = ();
our @BlackJack_DealerCardsStr = ();
our $BlackJack_PlayerPoints = 0;
our $BlackJack_DealerPoints = 0;
our $BlackJack_GameCondition = 0; # 1 = player lost (bust), 2 = player wins, 3 = player gets black jack, 4 = push (player and dealer tie)

sub BlackJack_GameReset {
	@BlackJack_CardsNumList = (1..52);
	@BlackJack_PlayerCardsNum = ();
	@BlackJack_DealerCardsNum = ();
	@BlackJack_PlayerCardsStr = ();
	@BlackJack_DealerCardsStr = ();
	$BlackJack_PlayerPoints = 0;
	$BlackJack_DealerPoints = 0;
	$BlackJack_GameCondition = 0;
}

sub BlackJack_Init {
	for (my $i = 0; $i < 2; $i++) {
		TRYAGAIN1:
		my $indexCardNumList = int(rand(51));
		my $cardNum = $BlackJack_CardsNumList[$indexCardNumList];
		if ($cardNum == 0) {
			goto TRYAGAIN1;
		}

		my $cardString = "";
		$BlackJack_CardsNumList[$indexCardNumList] = 0;
		my $suitNum = $cardNum % 4;
		my $cardVal = $carNum % 13 + 1;

		push(@BlackJack_PlayerCardsNum, $cardNum);

		if ($cardVal == 1) {
			$cardString = $cardString . "Ace of ";
		}

		elsif ($cardVal == 11) {
			$cardString = $cardString . "Jack of ";
		}

		elsif ($cardVal == 12) {
			$cardString = $cardString . "Queen of ";
		}

		elsif ($cardVal == 13) {
			$cardString = $cardString . "King of ";
		}
		else {
			$cardString = $cardString . $cardVal . " of ";
		}


		if ($suitNum == 0) {
			$cardString . "Spades";
		}
		elsif ($suitNum == 1) {
			$cardString . "Spades";
		}
		elsif ($suitNum == 2) {
			$cardString . "Diamonds";
		}
		elsif ($suitNum == 3) {
			$cardString . "Hearts";
		}

		if ($cardVal == 11 || $cardVal == 12 || $cardVal == 13) {
			$BlackJack_PlayerPoints += 10;
		}
		elsif ($cardVal < 11 && $cardVal > 1) {
			$BlackJack_PlayerPoints += $cardVal;
		}

		if ($cardVal == 1) {
			if ($BlackJack_PlayerPoints < 21) {
				$BlackJack_PlayerPoints += 11;
			}
			else {
				$BlackJack_PlayerPoints += 1;
			}
		}

		push(@BlackJack_PlayerCardsStr, $cardString);

	}
	print("Dealing dealer cards.")
	for (my $i = 0; $i < 2; $i++) {
		TRYAGAIN2:
		my $indexCardNumList = int(rand(51));
		my $cardNum = $BlackJack_CardsNumList[$indexCardNumList];
		if ($cardNum == 0) {
			goto TRYAGAIN2;
		}

		my $cardString = "";
		$BlackJack_CardsNumList[$indexCardNumList] = 0;
		my $suitNum = $cardNum % 4;
		my $cardVal = $carNum % 13 + 1;

		push(@BlackJack_DealerCardsNum, $cardNum);

		if ($cardVal == 1) {
			$cardString = $cardString . "Ace of ";
		}

		elsif ($cardVal == 11) {
			$cardString = $cardString . "Jack of ";
		}

		elsif ($cardVal == 12) {
			$cardString = $cardString . "Queen of ";
		}

		elsif ($cardVal == 12) {
			$cardString = $cardString . "King of ";
		}
		else {
			$cardString = $cardString . $cardVal . " of ";
		}


		if ($suitNum == 0) {
			$cardString . "Spades";
		}
		elsif ($suitNum == 1) {
			$cardString . "Clubs";
		}
		elsif ($suitNum == 2) {
			$cardString . "Diamonds";
		}
		elsif ($suitNum == 3) {
			$cardString . "Hearts";
		}

		if ($cardVal == 11 || $cardVal == 12 || $cardVal == 13) {
			$BlackJack_DealerPoints += 10;
		}
		elsif ($cardVal < 11 && $cardVal > 1) {
			$BlackJack_DealerPoints += $cardVal;
		}

		if ($cardVal == 1) {
			if ($BlackJack_PlayerPoints < 21) {
				$BlackJack_DealerPoints += 11;
			}
			else {
				$BlackJack_DealerPoints += 1;
			}
		}

		push(@BlackJack_DealerCardsStr, $cardString);

	}
	quest::say("You are playing Black Jack.")
	quest::say("You have a $BlackJack_PlayerCardsStr[0] and a $BlackJack_PlayerCardsStr[1]. The dealer has a $BlackJack_DealerCardsStr[0]. Do you want to [Hit] or [Stand]?");


}

sub BlackJack_Hit {
	if ($BlackJack_PlayerPoints <= 21) {
		TRYAGAIN3:
		my $indexCardNumList = int(rand(51));
		my $cardNum = $BlackJack_CardsNumList[$indexCardNumList];
		if ($cardNum == 0) {
			goto TRYAGAIN3;
		}

		my $cardString = "";
		$BlackJack_CardsNumList[$indexCardNumList] = 0;
		my $suitNum = $cardNum % 4;
		my $cardVal = $carNum % 13 + 1;

		push(@BlackJack_PlayerCardsNum, $cardNum);

		if ($cardVal == 1) {
			$cardString = $cardString . "Ace of ";
		}

		elsif ($cardVal == 11) {
			$cardString = $cardString . "Jack of ";
		}

		elsif ($cardVal == 12) {
			$cardString = $cardString . "Queen of ";
		}

		elsif ($cardVal == 13) {
			$cardString = $cardString . "King of ";
		}
		else {
			$cardString = $cardString . $cardVal . " of ";
		}


		if ($suitNum == 0) {
			$cardString . "Spades";
		}
		elsif ($suitNum == 1) {
			$cardString . "Clubs";
		}
		elsif ($suitNum == 2) {
			$cardString . "Diamonds";
		}
		elsif ($suitNum == 3) {
			$cardString . "Hearts";
		}

		if ($cardVal == 11 || $cardVal == 12 || $cardVal == 13) {
			$BlackJack_PlayerPoints += 10;
		}
		elsif ($cardVal < 11 && $cardVal > 1) {
			$BlackJack_PlayerPoints += $cardVal;
		}

		if ($cardVal == 1) {
			if ($BlackJack_PlayerPoints < 21) {
				$BlackJack_PlayerPoints += 11;
			}
			else {
				$BlackJack_PlayerPoints += 1;
			}
		}

		push(@BlackJack_PlayerCardsStr, $cardString);

	}
	else {
		BlackJack_RecalculatePlayerPoints();
	}
	if ($BlackJack_DealerPoints <= 21) {
		if ($BlackJack_DealerPoints < 17) {
			TRYAGAIN4:
			my $indexCardNumList = int(rand(51));
			my $cardNum = $BlackJack_CardsNumList[$indexCardNumList];
			if ($cardNum == 0) {
				goto TRYAGAIN4;
			}

			my$cardString = "";
			$BlackJack_CardsNumList[$indexCardNumList] = 0;
			my $suitNum = $cardNum % 4;
			my$cardVal = $carNum % 13 + 1;

			push(@BlackJack_DealerCardsNum, $cardNum);

			if ($cardVal == 1) {
				$cardString = $cardString . "Ace of ";
			}

			elsif ($cardVal == 11) {
				$cardString = $cardString . "Jack of ";
			}

			elsif ($cardVal == 12) {
				$cardString = $cardString . "Queen of ";
			}

			elsif ($cardVal == 12) {
				$cardString = $cardString . "King of ";
			}
			else {
				$cardString = $cardString . $cardVal . " of ";
			}


			if ($suitNum == 0) {
				$cardString . "Spades";
			}
			elsif ($suitNum == 1) {
				$cardString . "Clubs";
			}
			elsif ($suitNum == 2) {
				$cardString . "Diamonds";
			}
			elsif ($suitNum == 3) {
				$cardString . "Hearts";
			}

			if ($cardVal == 11 || $cardVal == 12 || $cardVal == 13) {
				$BlackJack_DealerPoints += 10;
			}
			elsif ($cardVal < 11 && $cardVal > 1) {
				$BlackJack_DealerPoints += $cardVal;
			}

			if ($cardVal == 1) {
				if ($BlackJack_PlayerPoints < 21) {
					$BlackJack_DealerPoints += 11;
				}
				else {
					$BlackJack_DealerPoints += 1;
				}
			}

			push(@BlackJack_DealerCardsStr, $cardString);

		}
	}
	else {
		BlackJack_RecalculateDealerPoints();
	}

	quest::say("You have:");
	for my $i (@BlackJack_PlayerCardsStr) {
		quest::say("$i");
	}
	quest::say("The dealer has: ");
	quest::say("$BlackJack_DealerCardsStr[0]");
	quest::say("Do you want to [Hit] or [Stand]?");
}

sub BlackJack_Stand {
	if ($BlackJack_PlayerPoints > 21) {
		BlackJack_RecalculatePlayerPoints();
	}

	if ($BlackJack_DealerPoints > 21) {
		BlackJack_RecalculateDealerPoints();
	}
	elsif ($BlackJack_DealerPoints <= 21) {
		if ($BlackJack_DealerPoints < 17) {
			TRYAGAIN5:
			my $indexCardNumList = int(rand(51));
			my $cardNum = $BlackJack_CardsNumList[$indexCardNumList];
			if ($cardNum == 0) {
				goto TRYAGAIN5;
			}

			my$cardString = "";
			$BlackJack_CardsNumList[$indexCardNumList] = 0;
			my $suitNum = $cardNum % 4;
			my$cardVal = $carNum % 13 + 1;

			push(@BlackJack_DealerCardsNum, $cardNum);

			if ($cardVal == 1) {
				$cardString = $cardString . "Ace of ";
			}

			elsif ($cardVal == 11) {
				$cardString = $cardString . "Jack of ";
			}

			elsif ($cardVal == 12) {
				$cardString = $cardString . "Queen of ";
			}

			elsif ($cardVal == 12) {
				$cardString = $cardString . "King of ";
			}
			else {
				$cardString = $cardString . $cardVal . " of ";
			}


			if ($suitNum == 0) {
				$cardString . "Spades";
			}
			elsif ($suitNum == 1) {
				$cardString . "Clubs";
			}
			elsif ($suitNum == 2) {
				$cardString . "Diamonds";
			}
			elsif ($suitNum == 3) {
				$cardString . "Hearts";
			}

			if ($cardVal == 11 || $cardVal == 12 || $cardVal == 13) {
				$BlackJack_DealerPoints += 10;
			}
			elsif ($cardVal < 11 && $cardVal > 1) {
				$BlackJack_DealerPoints += $cardVal;
			}

			if ($cardVal == 1) {
				if ($BlackJack_PlayerPoints < 21) {
					$BlackJack_DealerPoints += 11;
				}
				else {
					$BlackJack_DealerPoints += 1;
				}
			}

			push(@BlackJack_DealerCardsStr, $cardString);

		}
	}

	if ($BlackJack_PlayerPoints == $BlackJack_DealerPoints && $BlackJack_DealerPoints == 21) {
		$BlackJack_GameCondition = 4;
	}
	elsif ($BlackJack_PlayerPoints > 21) {
		$BlackJack_GameCondition = 1; # Bust (lose condition)
	}
	elsif ($BlackJack_PlayerPoints == 21) {
		$BlackJack_GameCondition = 3;
	}
	else {
		if ($BlackJack_PlayerPoints < $BlackJack_DealerPoints) {
			$BlackJack_GameCondition = 2; # Win condition
		}
		elsif ($BlackJack_PlayerPoints == $BlackJack_DealerPoints) {
			$BlackJack_GameCondition = 4; # Tie (push) condition;
		}
		elsif ($BlackJack_PlayerPoints > $BlackJack_DealerPoints) {
			$BlackJack_GameCondition = 1; # lose condition (lost to dealer)
		}
	}

}

sub BlackJack_RecalculatePlayerPoints {
	if ($BlackJack_PlayerPoints > 21) {
		$BlackJack_PlayerPoints = 0;
		for my $i (@BlackJack_PlayerCardsNum) {
			$BlackJack_PlayerPoints += $i
		}
	}

	BlackJack_RecalculateDealerPoints();
}

sub BlackJack_RecalculateDealerPoints {
	if ($BlackJack_DealerPoints > 21) {
		$BlackJack_DealerPoints = 0;
		for my $i (@BlackJack_DealerCardsNum) {
			$BlackJack_DealerPoints += $i
		}
	}

	BlackJack_RecalculatePlayerPoints();
}

# Message event for NPC, right now responds to hail
sub EVENT_SAY {
    #:: Match say message for "hail", /i for case insensitive
    if ($text=~/hail/i){
     quest::say("Hello, $name!. Welcome to the [Golden Bull]");
    }

    if ($text=~/Golden Bull/i){
     my $intro = "Here at the Golden Bull, you can spend your money for the chance to WIN WIN WIN.";
	 my $TextToCenter2 = plugin::PWAutoCenter(" Black Jack");
	 my $TextToCenter3 = plugin::PWAutoCenter(" Poker");
	 my $TextToCenter4 = plugin::PWAutoCenter(" Roulette");
	 my $TextToCenter5 = plugin::PWAutoCenter(" Once you have picked your game, please follow the rules listed on how to play.");
	 my $Indent = plugin::PWIndent();
	 my $Yel = plugin::PWColor("Yellow");
	 my $Blu = plugin::PWColor("Light Blue");
	 my $Red = plugin::PWColor("Red");
	 my $grn = plugin::PWColor("Forest Green");


	 quest::popup("Welcome to the Golden Bull", "$intro </c> <br><br> $Yel $TextToCenter2 </c><br><br> $Blu $TextToCenter3 </c><br><br> $Red $TextToCenter4 </c><br><br> $TextToCenter5 </c> <br>");
	 quest::say("What do you want to play?");
	 quest::say("[Black Jack]");
	 quest::say("[Poker]");
	 quest::say("[Roulette]");
    }

	if ($text=~/Test/i) {
        my $dialogMessage = "{title: TestBox} {button_one: Change Game} {button_two: RightClick} wintype:1 Hello Game";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
    }

	if ($text=~/Black Jack/i){
		BlackJack_Init();
	}

	if ($text=~/Poker/i){
		quest::say("This game is currently closed");
	}

	if ($text=~/Roulette/i){
		my $RoulRules = "Roulette is a game where you bet on the numbers 0 - 36 and if you bet is correct, you will be rewarded with a payout equivalent to the odds of the bet.";
		my $TextToCenterRoul = plugin::PWAutoCenter(" What can you bet on?");
		my $TextToCenterRoul2 = plugin::PWAutoCenter(" Numbers.");
		my $TextToCenterRoul3 = plugin::PWAutoCenter(" Odd / Even");
		my $TextToCenterRoul4 = plugin::PWAutoCenter(" 1st12 / 2nd12 / 3rd12");
		my $TextToCenterRoul5 = plugin::PWAutoCenter(" 1st18 / 2nd18");
		my $TextToCenterRoul6 = plugin::PWAutoCenter(" Column1  (1,4,7, . . 34)");
		my $TextToCenterRoul7 = plugin::PWAutoCenter(" Column2  (2,5,8, . . 35)");
		my $TextToCenterRoul8 = plugin::PWAutoCenter(" Column3  (3,6,9, . . 36)");
		my $TextToCenterRoul9 = plugin::PWAutoCenter(" Please tell the dealer what you want to bet on. If you want to select multiple number, please type each number seperated by a comma.");
		my $TextToCenterRoul10 = plugin::PWAutoCenter(" First play your bets, then hand me the ammount of money you want to play with.");
			 quest::popup("Rules of Roulette", "$RoulRules </c><br><br> $TextToCenterRoul </c><br> $TextToCenterRoul2 </c><br> $TextToCenterRoul3 </c><br> $TextToCenterRoul4 </c><br> $TextToCenterRoul5 </c><br> $TextToCenterRoul6 </c><br> $TextToCenterRoul7 </c><br> $TextToCenterRoul8 </c><br><br> $TextToCenterRoul9 </c><br> $TextToCenterRoul10 </c><br>");
	}

	if ($text=~/Stand/i) {
		quest::say("NOT IMPLEMENTED YET!!!!");
	}

	if ($text=~/Hit/i) {
		quest::say("NOT IMPLEMENTED YET!!!!");
	}

}

our $games = 2;
our $gameSelect = 0;

sub EVENT_POPUPRESPONSE {
		 if($popupid == 99999){
			 	 PopUpChange($gameSelect);
		 }

		 if($popupid == 100000){

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


sub PopUpChange()
{
    if($gameSelect == 0)
	{
		$gameSelect++;
		my $dialogMessage = "{title: ROULETTE} {button_one: Change Game} {button_two: SELECT GAME} wintype:1 SPIN SPIN SPIN";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
		quest::say("You are playing roulette    $gameSelect");
	}

	elsif($gameSelect==1)
	{
		$gameSelect++;
		my $dialogMessage = "{title: POKER} {button_one: Change Game} {button_two: SELECT GAME} wintype:1 DANCE ON THEIR GRAVES";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
		quest::say("You are playing Poker    $gameSelect");
	}

	elsif($gameSelect==2)
	{
		$gameSelect=0;
		my $dialogMessage = "{title: BLACKJACK} {button_one: Change Game} {button_two: SELECT GAME} wintype:1 ONLY THE CLUBS AND SPADES";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
		quest::say("You are playing BlackJack   $gameSelect");
	}
}
