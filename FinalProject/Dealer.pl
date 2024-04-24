our $BlackJack_Total;
our @BlackJack_CardsNumList;
our @BlackJack_PlayerCardsNum;
our @BlackJack_DealerCardsNum;
our @BlackJack_PlayerCardsStr;
our @BlackJack_DealerCardsStr;
our $BlackJack_PlayerPoints;
our $BlackJack_DealerPoints;
our $BlackJack_GameCondition;

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

sub BlackJack_Start{
	$BlackJack_Total = $total;
	if ($BlackJack_Total > 0) {
		BlackJack_Init();
	}
	else {
		quest::say("You need to place your bet before starting.");
		$BlackJack_BeginBool = 0;
	}
}


sub BlackJack_Init {
	BlackJack_GameReset();
	for ($i = 0; $i < 2; $i++) {
		TRYAGAIN1:
		my $indexCardNumList = int(rand(51));
		my $cardNum = $BlackJack_CardsNumList[$indexCardNumList];
		if ($cardNum == 0) {
			goto TRYAGAIN1;
		}

		my $cardString = "";
		$BlackJack_CardsNumList[$indexCardNumList] = 0;
		my $suitNum = $cardNum % 4;
		my $cardVal = $cardNum % 13 + 1;

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
			$cardString = $cardString . "Spades";
		}
		elsif ($suitNum == 1) {
			$cardString = $cardString . "Clubs";
		}
		elsif ($suitNum == 2) {
			$cardString = $cardString . "Diamonds";
		}
		elsif ($suitNum == 3) {
			$cardString = $cardString . "Hearts";
		}

		if ($cardVal == 11 || $cardVal == 12 || $cardVal == 13) {
			$BlackJack_PlayerPoints += 10;
		}
		elsif ($cardVal < 11 && $cardVal > 1) {
			$BlackJack_PlayerPoints += $cardVal;
		}

		if ($cardVal == 1) {
			$BlackJack_PlayerPoints += 11;
		}

		push(@BlackJack_PlayerCardsStr, $cardString);

	}
	for ($i = 0; $i < 2; $i++) {
		TRYAGAIN2:
		my $indexCardNumList = int(rand(51));
		my $cardNum = $BlackJack_CardsNumList[$indexCardNumList];
		if ($cardNum == 0) {
			goto TRYAGAIN2;
		}

		my $cardString = "";
		$BlackJack_CardsNumList[$indexCardNumList] = 0;
		my $suitNum = $cardNum % 4;
		my $cardVal = $cardNum % 13 + 1;

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

		elsif ($cardVal == 13) {
			$cardString = $cardString . "King of ";
		}
		else {
			$cardString = $cardString . $cardVal . " of ";
		}


		if ($suitNum == 0) {
			$cardString = $cardString . "Spades";
		}
		elsif ($suitNum == 1) {
			$cardString = $cardString . "Clubs";
		}
		elsif ($suitNum == 2) {
			$cardString = $cardString . "Diamonds";
		}
		elsif ($suitNum == 3) {
			$cardString = $cardString . "Hearts";
		}

		if ($cardVal == 11 || $cardVal == 12 || $cardVal == 13) {
			$BlackJack_DealerPoints += 10;
		}
		elsif ($cardVal < 11 && $cardVal > 1) {
			$BlackJack_DealerPoints += $cardVal;
		}

		if ($cardVal == 1) {
			$BlackJack_DealerPoints += 11;
		}

		push(@BlackJack_DealerCardsStr, $cardString);

	}
	quest::say("You are playing Blackjack.");
	if ($BlackJack_PlayerPoints == 21) {
		BlackJack_End();
	}
	elsif ($BlackJack_PlayerPoints > 21) {
		BlackJack_RecalculatePlayerPoints();
		BlackJack_End();
	}
	else {
		quest::say("You have a $BlackJack_PlayerCardsStr[0] and a $BlackJack_PlayerCardsStr[1]. You have $BlackJack_PlayerPoints points. I have a $BlackJack_DealerCardsStr[0]. Do you want to [Hit] or [Stand]?");
		my $dialogMessage = "{title: Blackjack} {button_one: Hit} {button_two: Stand} wintype:1 You have a $BlackJack_PlayerCardsStr[0] and a $BlackJack_PlayerCardsStr[1]. You have $BlackJack_PlayerPoints points. I have a $BlackJack_DealerCardsStr[0]. Do you want to [Hit] or [Stand]?";
				quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
}

sub BlackJack_Hit {
	if ($BlackJack_PlayerPoints < 21) {
		TRYAGAIN3:
		my $indexCardNumList = int(rand(51));
		my $cardNum = $BlackJack_CardsNumList[$indexCardNumList];
		if ($cardNum == 0) {
			goto TRYAGAIN3;
		}

		my $cardString = "";
		$BlackJack_CardsNumList[$indexCardNumList] = 0;
		my $suitNum = $cardNum % 4;
		my $cardVal = $cardNum % 13 + 1;

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
			$cardString = $cardString . "Spades";
		}
		elsif ($suitNum == 1) {
			$cardString = $cardString . "Clubs";
		}
		elsif ($suitNum == 2) {
			$cardString = $cardString . "Diamonds";
		}
		elsif ($suitNum == 3) {
			$cardString = $cardString . "Hearts";
		}

		if ($cardVal == 11 || $cardVal == 12 || $cardVal == 13) {
			$BlackJack_PlayerPoints += 10;
		}
		elsif ($cardVal < 11 && $cardVal > 1) {
			$BlackJack_PlayerPoints += $cardVal;
		}

		if ($cardVal == 1) {
			$BlackJack_PlayerPoints += 11;
		}

		push(@BlackJack_PlayerCardsStr, $cardString);

	}
	if ($BlackJack_DealerPoints < 21) {
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
			my$cardVal = $cardNum % 13 + 1;

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

			elsif ($cardVal == 13) {
				$cardString = $cardString . "King of ";
			}
			else {
				$cardString = $cardString . $cardVal . " of ";
			}


			if ($suitNum == 0) {
				$cardString = $cardString . "Spades";
			}
			elsif ($suitNum == 1) {
				$cardString = $cardString . "Clubs";
			}
			elsif ($suitNum == 2) {
				$cardString = $cardString . "Diamonds";
			}
			elsif ($suitNum == 3) {
				$cardString = $cardString . "Hearts";
			}

			if ($cardVal == 11 || $cardVal == 12 || $cardVal == 13) {
				$BlackJack_DealerPoints += 10;
			}
			elsif ($cardVal < 11 && $cardVal > 1) {
				$BlackJack_DealerPoints += $cardVal;
			}

			if ($cardVal == 1) {
				$BlackJack_DealerPoints += 11;
			}

			push(@BlackJack_DealerCardsStr, $cardString);

		}
	}
	if ($BlackJack_PlayerPoints > 21) {
		BlackJack_RecalculatePlayerPoints();
		BlackJack_End();
	}
	elsif ($BlackJack_PlayerPoints == 21) {
		BlackJack_End();
	}
	else {
		quest::say("You have:");
		for $i (@BlackJack_PlayerCardsStr) {
			quest::say("            $i");
		}
		quest::say("You have $BlackJack_PlayerPoints points.");
		quest::say("I have: ");
		quest::say("         $BlackJack_DealerCardsStr[0]");
		quest::say("Do you want to [Hit] or [Stand]?");
		my $dialogMessage = "{title: Blackjack} {button_one: Hit} {button_two: Stand} wintype:1 You have: @BlackJack_PlayerCardsStr. You have $BlackJack_PlayerPoints. I have $BlackJack_DealerCardsStr[0]. Do you want to [Hit] or [Stand]?";
		quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
}

sub BlackJack_Stand {
	if ($BlackJack_DealerPoints > 21 ) {
		BlackJack_RecalculateDealerPoints();
	}
	elsif ($BlackJack_DealerPoints < 21) {
		while ($BlackJack_DealerPoints < 17) {
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
				$cardString = $cardString . "Spades";
			}
			elsif ($suitNum == 1) {
				$cardString = $cardString . "Clubs";
			}
			elsif ($suitNum == 2) {
				$cardString = $cardString . "Diamonds";
			}
			elsif ($suitNum == 3) {
				$cardString = $cardString . "Hearts";
			}

			if ($cardVal == 11 || $cardVal == 12 || $cardVal == 13) {
				$BlackJack_DealerPoints += 10;
			}
			elsif ($cardVal < 11 && $cardVal > 1) {
				$BlackJack_DealerPoints += $cardVal;
			}

			if ($cardVal == 1) {
				$BlackJack_DealerPoints += 11;
			}

			push(@BlackJack_DealerCardsStr, $cardString);

		}
		if ($BlackJack_DealerPoints > 21) {
			BlackJack_RecalculateDealerPoints();
		}
		if ($BlackJack_PlayerPoints > 21) {
			BlackJack_RecalculatePlayerPoints();
		}
		BlackJack_End();
	}
}

sub BlackJack_End() {
	my $dialogMessage = "{title: Blackjack} {button_one: Hit} {button_two: Stand} wintype:1 ";
	if ($BlackJack_PlayerPoints == $BlackJack_DealerPoints && $BlackJack_DealerPoints == 21) {
		$BlackJack_GameCondition = 4;
		$dialogMessage = $dialogMessage . "Pushed! We both got blackjack.";
		quest::say("Pushed! We both got blackjack.");
	}
	elsif ($BlackJack_PlayerPoints > 21) {
		$BlackJack_GameCondition = 1; # Bust (lose condition)
		quest::say("Busted! You lose!");
		$dialogMessage = $dialogMessage . "Busted! You lose!";
		$BlackJack_Total = 0;
	}
	elsif ($BlackJack_PlayerPoints == 21) {
		$BlackJack_GameCondition = 3; # Black jack condition
		quest::say("You got blackjack! You win!");
		$dialogMessage = $dialogMessage . "You got blackjack! You win!";
		$BlackJack_Total = $BlackJack_Total * 3;
	}
	elsif ($BlackJack_DealerPoints == 21 && $BlackJack_PlayerPoints < $BlackJack_DealerPoints) {
		$BlackJack_GameCondition = 1; # Bust (lose condition)
		quest::say("I got blackjack! You lose!");
		$dialogMessage = $dialogMessage . "I got blackjack! You lose!";
		$BlackJack_Total = 0;
	}
	elsif ($BlackJack_DealerPoints > 21) {
		$BlackJack_GameCondition = 2; # Bust (lose condition)
		quest::say("I busted! You win!");
		$dialogMessage = $dialogMessage . "I busted! You win!";
		$BlackJack_Total = 2 * $BlackJack_Total;
	}
	else {
		if ($BlackJack_PlayerPoints > $BlackJack_DealerPoints) {
			$BlackJack_GameCondition = 2; # Win condition
			quest::say("You won! You got more points than me without going over 21.");
			$dialogMessage = $dialogMessage . "You won! You got more points than me without going over 21.";
			$BlackJack_Total = 2 * $BlackJack_Total;
		}
		elsif ($BlackJack_PlayerPoints == $BlackJack_DealerPoints) {
			$BlackJack_GameCondition = 4; # Tie (push) condition;
			quest::say("Pushed! We got the same amount of points.");
			$dialogMessage = $dialogMessage . "Pushed! We got the same amount of points.";
		}
		elsif ($BlackJack_PlayerPoints < $BlackJack_DealerPoints) {
			$BlackJack_GameCondition = 1; # lose condition (lost to dealer)
			quest::say("You lost! You got less points than me.");
			$dialogMessage = $dialogMessage . "You lost! You got less points than me.";
			$BlackJack_Total = 0;
		}
	}

	$total = $BlackJack_Total;
	quest::say("You had $BlackJack_PlayerPoints points. I had $BlackJack_DealerPoints points.");
	$dialogMessage = $dialogMessage . "You had $BlackJack_PlayerPoints points. I had $BlackJack_DealerPoints points.";
	getChange();
	quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	BlackJack_GameReset();
	$BlackJack_BeginBool = 0;
}

sub BlackJack_RecalculatePlayerPoints {
	$BlackJack_PlayerPoints = 0;
	for $i (@BlackJack_PlayerCardsNum) {
		my $cardVal = $i % 13 + 1;
		if ($cardVal == 11 || $cardVal == 12 || $cardVal == 13) {
			$BlackJack_PlayerPoints += 10;
		}
		elsif ($cardVal < 11 && $cardVal >= 1) {
			$BlackJack_PlayerPoints += $cardVal;
		}
	}
}

sub BlackJack_RecalculateDealerPoints {
	$BlackJack_DealerPoints = 0;
	for $i (@BlackJack_DealerCardsNum) {
		my $cardVal = $i % 13 + 1;
		if ($cardVal == 11 || $cardVal == 12 || $cardVal == 13) {
			$BlackJack_DealerPoints += 10;
		}
		elsif ($cardVal < 11 && $cardVal >= 1) {
			$BlackJack_DealerPoints += $cardVal;
		}
	}
}

our @bets;
our $games = 2;
our $gameSelect = 0;
our $layer = 0;
our $boolean = 0;
our $String;
our @Results = ();
our @Currenthand = ();
our @Newhand = ();
our @DealerHand = ();
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
our $Card1FD = "";
our $Card2FD = "";
our $Card3FD = "";
our $Card4FD = "";
our $Card5FD = "";
our $UIProgression = 0;
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
our $MoneyCheck = 0;
our $BeginPoker = 0;
our $total = 0;
our $copper_return = 0;
our $silver_return = 0;
our $gold_return = 0;

sub EVENT_POPUPRESPONSE {
		 if($popupid == 99999)
		 {
		    if($layer==0){PopUpChange();}
			elsif($layer==3){Roulette();}
			elsif($layer==6 && $RRP > 3){RouletteBet();}
		 }
		 if($popupid == 100000){
			if($layer == 6){$boolean = 1;}
			if($layer > 5){ $layer +=5;}
			elsif($layer >2 && $layer < 5) {$layer += $games +1;}
			elsif($layer==0){$layer = $games + $gameSelect;}

		    if($layer==3){Roulette();}
			elsif($layer==6){RouletteBet();
		 }
}

sub getChange()
{
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
}


sub PopUpChange()
{
    if($gameSelect == 0)
	{
		$gameSelect++;
		my $dialogMessage = "{title: ROULETTE} {button_one: Change Game} {button_two: SELECT GAME} wintype:1 SPIN SPIN SPIN";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
	elsif($gameSelect==1)
	{
		$gameSelect++;
		my $Yel = plugin::PWColor("Yellow");
	    my $Blu = plugin::PWColor("Light Blue");
		my $Wht = plugin::PWColor("White");
		my $dialogMessage = "{title: POKER} {button_one: Change Game} {button_two: Poker} wintype:1 You will be given 5 cards, you can either $Blu swap $Wht them and get new cards from the same deck or $Yel keep $Wht them if you are confident. Try and get better cards than the Dealer!";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
	elsif($gameSelect==2)
	{
		$gameSelect=0;
		my $dialogMessage = "{title: BLACKJACK} {button_one: Change Game} {button_two: Black jack} wintype:1 ONLY THE CLUBS AND SPADES";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
}
our $RRP = 0;
our $tab = "------";
sub Roulette()
{
	if($RRP ==0)
	{
		$RRP++;
		my $RoulRules = "Roulette is a game where you bet on the numbers 0 - 36 and if you bet is correct, you will be rewarded with a payout equivalent to the odds of the bet.";
		my $RoulRules1 = "$tab  Click <c \"#00F0F0\"> {More Bets} </c> to look at different options on how to bet.";
	    my $RoulRules2 = "$tab  Click <c \"#00F0F0\"> {Bet Now} </c> to bet with that option.";
		my $RoulRules3 = "$tab  To Bet with random numbers please refer to the <c \"#00F0F0\">Numbers</c> page.";
		my $RoulRules4 = "$tab  Once you have placed a bet it will be saved for ease of use. If you want to change your bet just redo it.";
		my $RoulRules5 = "$tab  To get started, click the continue button.";
	    my $dialogMessage = "{title: Roulette Rules} wintype:0 <br> $RoulRules <br><br> $RoulRules1 <br> $RoulRules2 <br> $RoulRules3 <br> $RoulRules4 <br> $RoulRules5 <br><br>";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
	elsif($RRP ==1)
	{
		$RRP++;
		my $text = "You will bet on if your number is odd or even.";
		my $payout = "$tab  If your bet is correct you will recieve <c \"#00F0F0\"> x2 </c> your bet.";
		my $dialogMessage = "{title: Odd or even} {button_one: More Bets} {button_two: Bet Now} wintype:1 <br> $text <br> $payout <br>";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
    elsif($RRP ==2)
	{
		$RRP++;
		my $text = "You will bet on if your number is Low{1...18} or High {19...36}.";
		my $payout = "$tab  If your bet is correct you will recieve <c \"#00F0F0\"> x2 </c> your bet.";
		my $dialogMessage = "{title: Low or High} {button_one: More Bets} {button_two: Bet Now} wintype:1 <br> $text <br> $payout <br>";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
    elsif($RRP ==3)
	{
		$RRP++;
		my $text = "You will bet on if your number is in the first dozen {1...12}, second dozen {13...24}, or last dozen {25...36}.";
		my $payout = "$tab  If your bet is correct you will recieve <c \"#00F0F0\"> x3 </c> your bet.";
		my $dialogMessage = "{title: Dozens} {button_one: More Bets} {button_two: Bet Now} wintype:1 <br> $text <br> $payout <br>";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
	elsif($RRP ==4)
	{
		$RRP++;
		my $text = "You will bet on if your number is in the first column {1,4,7,..34}, second column {2,5,8,..35}, or the last column {3,6,9,..36}.";
		my $payout = "$tab  If your bet is correct you will recieve <c \"#00F0F0\"> x3 </c> your bet.";
		my $dialogMessage = "{title: columns} {button_one: More Bets} {button_two: Bet Now} wintype:1 <br> $text <br> $payout <br>";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
	elsif($RRP ==5)
	{
		$RRP = 1;
		my $text = "You will be betting on if you think your numbers are the correct number";
		my $payout = "$tab  If your bet is correct you will recieve <c \"#00F0F0\"> x35 </c> your bet.";
		my $dialogMessage = "{title: Numbers} {button_one: More Bets} {button_two: Bet Now} wintype:1 <br> $text <br> $payout <br>";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
}

sub RouletteBet()
{
	my $Warning = "<br> Once You Place your bet, please give me the money you wish to bet to begin. <br><br><br><br> please restart the process if you have any problems. <br>";

	if($RRP == 1)
	{
		my $dialogMessage = "{title: Numbers} wintype:0 <br> Please enter the number you want to bet on. If you want to bet on multiple numbers, enter them and  seperated by a <c \"#00F0F0\"> , </c> . <br> an example would be 7,13,25,4  . <br><br>  $tab  <c \"#FF0000\"> Do not enter numbers outside the range of 0-36 </c> <br>  $tab  <c \"#FF0000\"> Do not enter any duplicate numbers </c>  <br><br>  Breaking any of these rules may result in you recieving less money than usual. Also if your payout has a porportion of a bronze coin it will round down. $warning";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
	elsif($RRP == 2)
	{
		my $dialogMessage = "{title: Odd or even} {button_one: Odd} {button_two: Even} wintype:1 <br> Please select the button that best fits. $warning";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
	elsif($RRP == 3)
	{
		my $dialogMessage = "{title: Low or High} {button_one: Low} {button_two: High} wintype:1 <br> Please select the button that best fits. $warning";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
	elsif($RRP == 4)
	{
		$RRP +=2;
		my $dialogMessage = "{title: First Dozen} {button_one: Change} {button_two: Select Bet} wintype:1 <br> Please select the button that best fits. $warning";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
	elsif($RRP == 5)
	{
		$RRP +=2;
		my $dialogMessage = "{title: First Column} {button_one: Change} {button_two: Select Bet} wintype:1 <br> Please select the button that best fits. $warning";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
	elsif($RRP == 6)
	{
		$RRP +=2;
		my $dialogMessage = "{title: Second Dozen} {button_one: Change} {button_two: Select Bet} wintype:1 <br> Please select the button that best fits. $warning";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
	elsif($RRP == 7)
	{
		$RRP +=2;
		my $dialogMessage = "{title: Second Column} {button_one: Change} {button_two: Select Bet} wintype:1 <br> Please select the button that best fits. $warning";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
	elsif($RRP == 8)
	{
		$RRP = 4;
		my $dialogMessage = "{title: Third Dozen} {button_one: Change} {button_two: Select Bet} wintype:1 <br> Please select the button that best fits. $warning";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
	elsif($RRP == 9)
	{
		$RRP = 5;
		my $dialogMessage = "{title: Third Column} {button_one: Change} {button_two: Select Bet} wintype:1 <br> Please select the button that best fits. $warning";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
}

sub RouletteCheck()
{
			my $int = CARD_GENERATOR();
			my $loss = "You Lose :c";
			my $dialogMessage = "";

if($RRP == 1)
	{
		my $numbers = join(',', @bets);
		my $payout = 36/@bets;
		my $found = 0;


		foreach my $num (@bets)
		{if ($num == $int) {
				   $total *= $payout;
				   $found = 1;
		 my $win = "Congrats you win $total token";
		 $dialogMessage = "{title: Results} wintype:0 <br> You bet on <c \"#00F0F0\"> $numbers </c>.<br> The number rolled is <c \"#00F0F0\"> $int </c>. <br><br> $win <br>";
        last; }}

			if($found == 0)
			{
		 $total = 0;
		 $dialogMessage = "{title: Results} wintype:0 <br> You bet on <c \"#00F0F0\"> $numbers </c>.<br> The number rolled is <c \"#00F0F0\"> $int </c>. <br><br> $loss<br>";
			}

		if($numbers == "")
		{
				 $dialogMessage = "{title: Results} wintype:0 <br> You bet on <c \"#00F0F0\"> NOTHING </c>.<br> The number rolled is <c \"#00F0F0\"> $int </c>. <br><br> Why did you pick this and not bet. YOU LOSE<br>";
		}

        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
	elsif($RRP == 2 && $boolean ==0)
	{
		if($int % 2 == 0)
		{
		$total = 0;
		my $dialogMessage = "{title: Results} wintype:0 <br> You bet on <c \"#00F0F0\"> Odd </c>.<br>The number rolled is <c \"#00F0F0\"> $int </c> and it is <c \"#00F0F0\"> Even </c>. <br><br> $loss <br>";
		}
		elsif($int % 2 == 1)
		{
		$total *= 2;
		my $win = "Congrats you win $total token";
		my $dialogMessage = "{title: Results} wintype:0 <br> You bet on <c \"#00F0F0\"> Odd </c>.<br> The number rolled is <c \"#00F0F0\"> $int </c> and it is <c \"#00F0F0\"> Odd </c>. <br><br> $win <br>";
		}
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
	elsif($RRP == 2 && $boolean ==1)
	{
		if($int % 2 == 0)
		{
		$total *= 2;
		my $win = "Congrats you win $total token";
		$dialogMessage = "{title: Results} wintype:0 <br> You bet on <c \"#00F0F0\"> Even </c>.<br>The number rolled is <c \"#00F0F0\"> $int </c> and it is <c \"#00F0F0\"> Even </c>. <br><br> $win <br>";
		}
		elsif($int % 2 == 1)
		{
		$total = 0;
		$dialogMessage = "{title: Results} wintype:0 <br> You bet on <c \"#00F0F0\"> Even</c>.<br> The number rolled is <c \"#00F0F0\"> $int </c> and it is <c \"#00F0F0\"> Odd </c>. <br><br> $loss <br>";
		}
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
	elsif($RRP == 3 && $boolean ==0)
	{
		if($int < 19 && $int > 0)
		{
		$total *= 2;
		my $win = "Congrats you win $total token";
		$dialogMessage = "{title: Results} wintype:0 <br> You bet on <c \"#00F0F0\"> Low </c>.<br>The number rolled is <c \"#00F0F0\"> $int </c> and it is <c \"#00F0F0\"> Low </c>. <br><br> $win <br>";
		}
		elsif($int > 18)
		{
		$total = 0;
		$dialogMessage = "{title: Results} wintype:0 <br> You bet on <c \"#00F0F0\"> Low </c>.<br> The number rolled is <c \"#00F0F0\"> $int </c> and it is <c \"#00F0F0\"> High </c>. <br><br> $loss <br>";
		}
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
	elsif($RRP == 3 && $boolean ==1)
	{
		if($int < 19 && $int > 0)
		{
		$total =0;
		$dialogMessage = "{title: Results} wintype:0 <br> You bet on <c \"#00F0F0\"> High </c>.<br>The number rolled is <c \"#00F0F0\"> $int </c> and it is <c \"#00F0F0\"> Low </c>. <br><br> $loss <br>";
		}
		elsif($int > 18)
		{
		$total *= 2;
		my $win = "Congrats you win $total token";
		$dialogMessage = "{title: Results} wintype:0 <br> You bet on <c \"#00F0F0\"> High </c>.<br> The number rolled is <c \"#00F0F0\"> $int </c> and it is <c \"#00F0F0\"> High </c>. <br><br> $win <br>";
		}
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
	elsif($RRP == 4)
	{

		if($int > 24)
		{
		$total *= 3;
		my $win = "Congrats you win $total token";
		$dialogMessage = "{title: Results} wintype:0 <br> You bet on <c \"#00F0F0\"> Third Dozen </c>.<br>The number rolled is <c \"#00F0F0\"> $int </c> and it is <c \"#00F0F0\"> in range </c>. <br><br> $win <br>";
		}
		else
		{
		$total = 0;
		$dialogMessage = "{title: Results} wintype:0 <br> You bet on <c \"#00F0F0\"> Third Dozen </c>.<br> The number rolled is <c \"#00F0F0\"> $int </c> and it is <c \"#00F0F0\"> out of range </c>. <br><br> $loss <br>";
		}
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);

	}
	elsif($RRP == 5)
	{
		if($int%3 ==0 && $int > 0)
		{
		$total *= 3;
		my $win = "Congrats you win $total token";
		$dialogMessage = "{title: Results} wintype:0 <br> You bet on <c \"#00F0F0\"> Third Column </c>.<br>The number rolled is <c \"#00F0F0\"> $int </c> and it is <c \"#00F0F0\"> in range </c>. <br><br> $win <br>";
		}
		else
		{
		$total = 0;
		$dialogMessage = "{title: Results} wintype:0 <br> You bet on <c \"#00F0F0\"> Third Column </c>.<br> The number rolled is <c \"#00F0F0\"> $int </c> and it is <c \"#00F0F0\"> out of range </c>. <br><br> $loss <br>";
		}
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
	elsif($RRP == 6)
	{
		if($int < 13 && $int > 0)
		{
		$total *= 3;
		my $win = "Congrats you win $total token";
		$dialogMessage = "{title: Results} wintype:0 <br> You bet on <c \"#00F0F0\"> First Dozen </c>.<br>The number rolled is <c \"#00F0F0\"> $int </c> and it is <c \"#00F0F0\"> in range </c>. <br><br> $win <br>";
		}
		else
		{
		$total = 0;
		$dialogMessage = "{title: Results} wintype:0 <br> You bet on <c \"#00F0F0\"> First Dozen </c>.<br> The number rolled is <c \"#00F0F0\"> $int </c> and it is <c \"#00F0F0\"> out of range </c>. <br><br> $loss <br>";
		}
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
	elsif($RRP == 7)
	{
		if($int%3 ==1 && $int > 0)
		{
		$total *= 3;
		my $win = "Congrats you win $total token";
		$dialogMessage = "{title: Results} wintype:0 <br> You bet on <c \"#00F0F0\"> First Column </c>.<br>The number rolled is <c \"#00F0F0\"> $int </c> and it is <c \"#00F0F0\"> in range </c>. <br><br> $win <br>";
		}
		else
		{
		$total = 0;
		$dialogMessage = "{title: Results} wintype:0 <br> You bet on <c \"#00F0F0\"> First Column </c>.<br> The number rolled is <c \"#00F0F0\"> $int </c> and it is <c \"#00F0F0\"> out of range </c>. <br><br> $loss <br>";
		}
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
	elsif($RRP == 8)
	{
		if($int < 25 && $int > 12)
		{
		$total *= 3;
		my $win = "Congrats you win $total token";
		$dialogMessage = "{title: Results} wintype:0 <br> You bet on <c \"#00F0F0\"> Second Dozen </c>.<br>The number rolled is <c \"#00F0F0\"> $int </c> and it is <c \"#00F0F0\"> in range </c>. <br><br> $win <br>";
		}
		else
		{
		$total = 0;
		$dialogMessage = "{title: Results} wintype:0 <br> You bet on <c \"#00F0F0\"> Second Dozen </c>.<br> The number rolled is <c \"#00F0F0\"> $int </c> and it is <c \"#00F0F0\"> out of range </c>. <br><br> $loss <br>";
		}
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
	elsif($RRP == 9)
	{
		if($int%3 ==2 && $int > 0)
		{
		$total *= 3;
		my $win = "Congrats you win $total token";
		$dialogMessage = "{title: Results} wintype:0 <br> You bet on <c \"#00F0F0\"> Second Column </c>.<br>The number rolled is <c \"#00F0F0\"> $int </c> and it is <c \"#00F0F0\"> in range </c>. <br><br> $win <br>";
		}
		else
		{
		$total = 0;
		$dialogMessage = "{title: Results} wintype:0 <br> You bet on <c \"#00F0F0\"> Second Column </c>.<br> The number rolled is <c \"#00F0F0\"> $int </c> and it is <c \"#00F0F0\"> out of range </c>. <br><br> $loss <br>";
		}
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}

}


sub CARD_GENERATOR {
  return int(rand(36));
}

sub POKER_START {
	#Function to generate 5 random cards from one deck
	@TempCards = (0,0,0,0,0);
	@CurrentCards = (0,0,0,0,0);
	if($_[0] == 0)
	{
	for($i = 0; $i<5; $i++)
	{
		POKERTRYAGAIN:
		$TempCards[$i] = ((int rand(51)) + 1);

		if(($TempCards[$i] == $CurrentCards[0]) or ($TempCards[$i] == $CurrentCards[1]) or ($TempCards[$i] == $CurrentCards[2]) or ($TempCards[$i] == $CurrentCards[3]) or ($TempCards[$i] == $CurrentCards[4]))
		{
			goto POKERTRYAGAIN;
		}
		$CurrentCards[$i] = $TempCards[$i];
	}
	}

	if($_[0] == 2)
	{
		if((int rand(5)) == 0)
		{
			$Rand = int rand(99);
			if($Rand == 0)
			{
				@CurrentCards = (1,13,12,11,10);
			}
			elsif(($Rand > 0) and ($Rand <= 3))
			{
				$TempRand = int rand(6) + 5;
				@CurrentCards = ($TempRand,$TempRand-1,$TempRand-2,$TempRand-3,$TempRand-4);
			}
			elsif(($Rand > 3) and ($Rand <= 11))
			{
				$TempRand = int rand(12) + 1;
				if($TempRand == 1)
				{
				@CurrentCards = ($TempRand, $TempRand + 13, $TempRand + 26, $TempRand + 39, $TempRand + 1);
				}
				else
				{
				@CurrentCards = ($TempRand, $TempRand + 13, $TempRand + 26, $TempRand + 39, $TempRand - 1);
				}
			}
			elsif(($Rand > 11) and ($Rand <= 26))
			{
				$TempRand = int rand(12) + 1;
				@CurrentCards = ($TempRand, $TempRand + 13, $TempRand + 26, $TempRand + 2 , $TempRand + 15);
			}
			elsif(($Rand > 26) and ($Rand <= 37))
			{
				$TempRand = 13;
				if($TempRand == 13)
				{
				@CurrentCards = ($TempRand, $TempRand - 6, $TempRand - 2, $TempRand - 7, $TempRand -9);
				}
			}
			elsif(($Rand > 37) and ($Rand <= 50))
			{
				@CurrentCards = (3, 16, 4, 29, 17);
			}
			elsif(($Rand > 50) and ($Rand <= 65))
			{
				$TempRand = int rand(12) + 1;
				@CurrentCards = ($TempRand, $TempRand + 13, $TempRand + 39, $TempRand +3, $TempRand + 20);
			}
			elsif(($Rand > 65) and ($Rand <= 85))
			{
				$TempRand = int rand(12) + 1;
				@CurrentCards = ($TempRand + 16, $TempRand + 13, $TempRand + 39, $TempRand +3, $TempRand + 20);
			}
			elsif($Rand > 85)
			{
				$TempRand = int rand(12) + 1;
				@CurrentCards = ($TempRand + 1, $TempRand + 28, $TempRand + 39, $TempRand +3, $TempRand + 20);
			}
		}
		else{
	for($i = 0; $i<5; $i++)
	{
		POKERTRYAGAIN1:
		$TempCards[$i] = ((int rand(51)) + 1);

		if(($TempCards[$i] == $CurrentCards[0]) or ($TempCards[$i] == $CurrentCards[1]) or ($TempCards[$i] == $CurrentCards[2]) or ($TempCards[$i] == $CurrentCards[3]) or ($TempCards[$i] == $CurrentCards[4]))
		{
			goto POKERTRYAGAIN1;
		}
		$CurrentCards[$i] = $TempCards[$i];
	}
	}
	}

	if($_[0] == 1)
	{
		if($Flag1 == 1)
		{
			POKERTRYAGAIN2:
		$TempCards[0] = ((int rand(51)) + 1);

		if(($TempCards[0] == $_[1]) or ($TempCards[0] == $_[2]) or ($TempCards[0] == $_[3]) or ($TempCards[0] == $_[4]) or ($TempCards[0] == $_[5]))
		{
			goto POKERTRYAGAIN2;
		}
		$CurrentCards[0] = $TempCards[0];
		}
		if($Flag1 == 0)
		{
		$CurrentCards[0] = $_[1];
		}

		if($Flag2 == 1)
		{
			POKERTRYAGAIN3:
		$TempCards[1] = ((int rand(51)) + 1);

		if(($TempCards[1] == $_[1]) or ($TempCards[1] == $_[2]) or ($TempCards[1] == $_[3]) or ($TempCards[1] == $_[4]) or ($TempCards[1] == $_[5]))
		{
			goto POKERTRYAGAIN3;
		}
		$CurrentCards[1] = $TempCards[1];
		}
		if($Flag2 == 0)
		{
		$CurrentCards[1] = $_[2];
		}

		if($Flag3 == 1)
		{
			POKERTRYAGAIN4:
		$TempCards[2] = ((int rand(51)) + 1);

		if(($TempCards[2] == $_[1]) or ($TempCards[2] == $_[2]) or ($TempCards[2] == $_[3]) or ($TempCards[2] == $_[4]) or ($TempCards[2] == $_[5]))
		{
			goto POKERTRYAGAIN4;
		}
		$CurrentCards[2] = $TempCards[2];
		}
		if($Flag3 == 0)
		{
		$CurrentCards[2] = $_[3];
		}

		if($Flag4 == 1)
		{
			POKERTRYAGAIN5:
		$TempCards[3] = ((int rand(51)) + 1);

		if(($TempCards[3] == $_[1]) or ($TempCards[3] == $_[2]) or ($TempCards[3] == $_[3]) or ($TempCards[3] == $_[4]) or ($TempCards[3] == $_[5]))
		{
			goto POKERTRYAGAIN5;
		}
		$CurrentCards[3] = $TempCards[3];
		}
		if($Flag4 == 0)
		{
		$CurrentCards[3] = $_[4];
		}

		if($Flag5 == 1)
		{
			POKERTRYAGAIN6:
		$TempCards[4] = ((int rand(51)) + 1);

		if(($TempCards[4] == $_[1]) or ($TempCards[4] == $_[2]) or ($TempCards[4] == $_[3]) or ($TempCards[4] == $_[4]) or ($TempCards[4] == $_[5]))
		{
			goto POKERTRYAGAIN6;
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
@Temp = sort { $a <=> $b } ($_[0] % 13, $_[1] % 13, $_[2] % 13, $_[3] % 13, $_[4] % 13);

@CardCounter = (0,0,0,0,0,0,0,0,0,0,0,0,0);


$Card1 = int($numeric[0]);
$Card2 = int($numeric[1]);
$Card3 = int($numeric[2]);
$Card4 = int($numeric[3]);
$Card5 = int($numeric[4]);

	if($_[5] == 0)
	{
		if($Temp[0] == 1 or $Temp[1] == 1 or $Temp[2] == 1 or $Temp[3] == 1 or $Temp[4] == 1)
		{
			$PHigh = 14;
		}
		elsif($Temp[0]== 0)
		{
		$PHigh = 13;
		}
		else
		{
			$PHigh = ($Temp[4]);
		}
	}
	if($_[5] == 1)
	{
		if($Temp[0] == 1 or $Temp[1] == 1 or $Temp[2] == 1 or $Temp[3] == 1 or $Temp[4] == 1)
		{
			$DHigh = 14;
		}
		elsif($Temp[0]== 0)
		{
		$DHigh = 13;
		}
		else
		{
			$DHigh = ($Temp[4]);
		}

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
		if($q == 1)
		{
		$PFour = 14;
		}
		else
		{
		$PFour = $q;
		}
	}
	if($_[5] == 1)
	{
		if($q == 1)
		{
		$DFour = 14;
		}
		else
		{
		$DFour = $q;
		}
	}
	}

#Checking for 3 of a kind
	if($CardCounter[$q] == 3)
	{
	$ThreeKind = 1;

	if($_[5] == 0)
	{
		if($q == 1)
		{
		$PThree = 14;
		}
		else
		{
		$PThree = $q;
		}
	}
	if($_[5] == 1)
	{
		if($q == 1)
		{
		$DThree = 14;
		}
		else
		{
		$DThree = $q;
		}

	}
	}

#Checking for pairs
	if($CardCounter[$q] == 2)
	{
	$OnePair = 1;

	if($_[5] == 0)
	{
		if($PairsCounted == 0)
		{
			if($q == 1)
			{
			$POne = 14;
			}
			else
			{
			$POne = $q;
			}
		}
		else
			{

			if($q == 1)
			{
			$PTwo = 14;
			}
			else
			{
			$PTwo = $q;
			}
		}
		}


	if($_[5] == 1)
	{
		if($PairsCounted == 0)
		{

			if($q == 1)
			{
			$DOne = 14;
			}
			else
			{
			$DOne = $q;
			}
		}
		else
		{
			if($q == 1)
			{
			$DTwo = 14;
			}
			else
			{
			$DTwo = $q;
			}
		}

	}
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
	my $intro = "Current Hand Power: ". $NewResults[0]. ". Hand Type: ". $NewResults[6];
	 my $TextToCenter2 = plugin::PWAutoCenter("You Win!");
	 my $TextToCenter3 = plugin::PWAutoCenter("You Lost");
	 my $TextToCenter4 = plugin::PWAutoCenter("Its a tie!");
	 #my $TextToCenter5 = plugin::PWAutoCenter($Card4F);
	 #my $TextToCenter6 = plugin::PWAutoCenter($Card5F);

	 my $Indent = plugin::PWIndent();
	 my $Yel = plugin::PWColor("Yellow");
	 my $Blu = plugin::PWColor("Light Blue");
	 my $Red = plugin::PWColor("Red");
	 my $grn = plugin::PWColor("Forest Green");

	if($_[0] > $_[1])
	{
		quest::popup("Results", "$intro </c> <br><br> $Yel $Card1F , $Yel $Card2F , $Yel $Card3F , $Yel $Card4F , $Yel $Card5F</c> <br><br> $Yel Dealers Hand: </c> <br><br> $Yel $ , $Yel $Card2FD , $Yel $Card3FD , $Yel $Card4FD , $Yel $Card5FD </c> <br><br> $grn $TextToCenter2");
		quest::givecash($copper_return * 2,$silver_return * 2,$gold_return * 2,$total * 2);
		quest::ding();
		return("Player Wins by ");
	}
	if($_[0] < $_[1])
	{
		quest::popup("Results", "$intro </c> <br><br> $Yel $Card1F , $Yel $Card2F , $Yel $Card3F , $Yel $Card4F , $Yel $Card5F</c> <br><br> $Yel Dealers Hand: </c> <br><br> $Yel $Card1FD , $Yel $Card2FD , $Yel $Card3FD , $Yel $Card4FD , $Yel $Card5FD </c> <br><br> $Red $TextToCenter3");
		return("Dealer Wins by ");
	}
	if($_[0] == $_[1])
	{
		quest::popup("Results", "$intro </c> <br><br> $Yel $Card1F , $Yel $Card2F , $Yel $Card3F , $Yel $Card4F , $Yel $Card5F</c> <br><br> $Yel Dealers Hand: </c> <br><br> $Yel $ , $Yel $Card2FD , $Yel $Card3FD , $Yel $Card4FD , $Yel $Card5FD </c> <br><br> $Blu $TextToCenter4");
		quest::givecash($copper_return,$silver_return,$gold_return,$total);
		return("Tie with ");
	}
}

sub POKER_DEALER_V_PLAYER{

		my $intro = "Current Hand Power: ". $NewResults[0]. ". Hand Type: ". $NewResults[6];
	 my $TextToCenter2 = plugin::PWAutoCenter("You Win!");
	 my $TextToCenter3 = plugin::PWAutoCenter("You Lost");
	 my $TextToCenter4 = plugin::PWAutoCenter("Its a tie!");
	 #my $TextToCenter5 = plugin::PWAutoCenter($Card4F);
	 #my $TextToCenter6 = plugin::PWAutoCenter($Card5F);

	 my $Indent = plugin::PWIndent();
	 my $Yel = plugin::PWColor("Yellow");
	 my $Blu = plugin::PWColor("Light Blue");
	 my $Red = plugin::PWColor("Red");
	 my $grn = plugin::PWColor("Forest Green");



	if($_[0] > $_[1])
	{
		quest::popup("Results", "$intro </c> <br><br> $Yel $Card1F , $Yel $Card2F , $Yel $Card3F , $Yel $Card4F , $Yel $Card5F</c> <br><br> $Yel Dealers Hand: </c> <br><br> $Yel $ , $Yel $Card2FD , $Yel $Card3FD , $Yel $Card4FD , $Yel $Card5FD </c> <br><br> $grn $TextToCenter2");
		quest::givecash($copper_return * 2,$silver_return * 2,$gold_return * 2,$total * 2);
		quest::ding();
		return("Player Wins by ". $_[2]);
	}
	elsif($_[0] < $_[1])
	{
		quest::popup("Results", "$intro </c> <br><br> $Yel $Card1F , $Yel $Card2F , $Yel $Card3F , $Yel $Card4F , $Yel $Card5F</c> <br><br> $Yel Dealers Hand: </c> <br><br> $Yel $ , $Yel $Card2FD , $Yel $Card3FD , $Yel $Card4FD , $Yel $Card5FD </c> <br><br> $Red $TextToCenter3");
		return("Dealer Wins by ". $_[3]);
	}
	elsif($_[0] == $_[1])
	{

		if($_[0] == 10)
		{
		return(CMPNUM($PHigh, $DHigh) . "Equal Cards");
		}
		elsif($_[0] == 9)
		{
		return(CMPNUM($PHigh,$DHigh) . "Higher Cards");
		}
		elsif($_[0] == 8)
		{
		return(CMPNUM($PFour,$DFour) . "Higher Cards");
		}
		elsif($_[0] == 7)
		{
		return(CMPNUM($PThree,$DThree) . "Higher Cards");
		}
		elsif($_[0] == 6)
		{
		return(CMPNUM($PHigh,$DHigh) . "Higher Cards");
		}
		elsif($_[0] == 5)
		{
		return(CMPNUM($PHigh,$DHigh) . "Higher Cards");
		}
		elsif($_[0] == 4)
		{
		return(CMPNUM($PThree,$DThree) . "Higher Cards");
		}
		elsif($_[0] == 3)
		{
		return(CMPNUM($PTwo,$DTwo) . "Higher Cards");
		}
		elsif($_[0] == 2)
		{
		return(CMPNUM($POne,$DOne) . "Higher Cards");
		}
		elsif($_[0] == 1)
		{
		return(CMPNUM($PHigh,$DHigh) . "Higher Cards");
		}
	}


}

sub POKER_CARD_NAMES{

	@Names = ('Ace of Hearts', 'Two of Hearts', 'Three of Hearts', 'Four of Hearts', 'Five of Hearts', 'Six of Hearts', 'Seven of Hearts', 'Eight of Hearts', 'Nine of Hearts', 'Ten of Hearts', 'Jack of Hearts', 'Queen of Hearts', 'King of Hearts','Ace of Clubs', 'Two of Clubs', 'Three of Clubs', 'Four of Clubs', 'Five of Clubs', 'Six of Clubs', 'Seven of Clubs', 'Eight of Clubs', 'Nine of Clubs', 'Ten of Clubs', 'Jack of Clubs', 'Queen of Clubs', 'King of Clubs', 'Ace of Diamonds', 'Two of Diamonds', 'Three of Diamonds', 'Four of Diamonds', 'Five of Diamonds', 'Six of Diamondss', 'Seven of Diamonds', 'Eight of Diamonds', 'Nine of Diamonds', 'Ten of Diamonds', 'Jack of Diamonds', 'Queen of Diamonds', 'King of Diamonds','Ace of Spades', 'Two of Spades', 'Three of Spades', 'Four of Spades', 'Five of Spades', 'Six of Spades', 'Seven of Spades', 'Eight of Spades', 'Nine of Spades', 'Ten of Spades', 'Jack of Spades', 'Queen of Spades', 'King of Spades');

	return($Names[$_[0] - 1]);

}

our $BlackJack_BeginBool = 0;
# Message event for NPC, right now responds to hail
sub EVENT_SAY {
    #:: Match say message for "hail", /i for case insensitive

		if ($text=~/Black jack/i){
			$BlackJack_BeginBool = 1;
			BlackJack_Start();
		}
		if ($text=~/Stand/i) {
			quest::say("You chose to stand.");
			BlackJack_Stand();
		}

		if ($text=~/Hit/i) {
			quest::say("You chose to hit.");
			BlackJack_Hit();
		}


     if ($text=~/hail/i){
	$games = 2;$gameSelect = 0;$layer = 0;$RRP = 0;$boolean = 0;
    my $dialogMessage = "{title: Welcome} wintype:0 Welcome to the <c \"#FFD700\"> Golden Bull </c>";
    quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
    }
	else
	{
		@bets = ();
		my @items = split(/\s*,\s*/, $text);
		foreach my $item (@items) {
			$item =~ s/[^\d]//g;
			if($item > -1 && $item < 37){push @bets, $item;}
		}
	}


    if ($text=~/Poker/i)
    {
	 @Currenthand = (0,0,0,0,0);
	 $Count = 0;
	 $UIProgression = 0;
  	$BeginPoker = 1;

	  my $intro = "You need to pay to start playing!";


	 my $Indent = plugin::PWIndent();
	 my $Yel = plugin::PWColor("Yellow");
	 my $Blu = plugin::PWColor("Light Blue");
	 my $Red = plugin::PWColor("Red");
	 my $grn = plugin::PWColor("Forest Green");


	  my $dialogMessage = "{title: Curernt Hand} {button_one: Cancel} {button_two: Play} wintype:1 $intro </c> <br><br>";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);

    }

	if($text=~/Stop/i)
	{
		quest::givecash($copper_return,$silver_return,$gold_return,$total);
		$MoneyCheck = 0;
		$total = 0;
		$copper_return = 0;
		$silver_return = 0;
		$gold_return = 0;
  		$BeginPoker = 0;
	}

  if (($text=~/Play/i) and ($MoneyCheck != 1))
    {
     my $intro = "You need to pay to start playing!";


	 my $Indent = plugin::PWIndent();
	 my $Yel = plugin::PWColor("Yellow");
	 my $Blu = plugin::PWColor("Light Blue");
	 my $Red = plugin::PWColor("Red");
	 my $grn = plugin::PWColor("Forest Green");


	  my $dialogMessage = "{title: Curernt Hand} {button_one: Cancel} {button_two: Play} wintype:1 $intro </c> <br><br>";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
    }
	if (($text=~/Cancel/i) and ($MoneyCheck != 1))
    {
     $BeginPoker = 0;
    }

     if (($text=~/Play/i) and ($MoneyCheck == 1))
    {
		$BeginPoker = 0;


	@Currenthand = (POKER_START(0,0,0,0,0,0));

	@Results = (POKER_LOGIC($Currenthand[0],$Currenthand[1],$Currenthand[2],$Currenthand[3],$Currenthand[4]));

	$Card1F = POKER_CARD_NAMES($Results[1]);
	$Card2F = POKER_CARD_NAMES($Results[2]);
	$Card3F = POKER_CARD_NAMES($Results[3]);
	$Card4F = POKER_CARD_NAMES($Results[4]);
	$Card5F = POKER_CARD_NAMES($Results[5]);

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

		$UIProgression = 1;

    }

	if (($text=~/Start Swapping/i) and ($UIProgression == 1))
	{
		$MoneyCheck = 0;
		$Count = 0;
		$Flag1 = 0;
		$Flag2 = 0;
		$Flag3 = 0;
		$Flag4 = 0;
		$Flag5 = 0;

		my $dialogMessage = "{title: $Card1F} {button_one: Keep Card} {button_two: Swap} wintype:1 $intro </c> <br><br> $Red $TextToCenter2 </c><br><br> $Yel $TextToCenter3 </c><br><br> $Yel $TextToCenter4 </c><br><br> $Yel $TextToCenter5 </c> <br><br> $Yel $TextToCenter6 </c> <br>";
		quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);

		$UIProgression = 2;
	}

	if (($text=~/Swap/i) and ($UIProgression == 2))
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

	if (($text=~/Restart/i)and ($UIProgression == 2))
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

	if (($text=~/Keep Card/i)and ($UIProgression == 2))
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


	if (($text=~/Confirm Hand/i) and ($UIProgression != 0))
     {

    @Newhand = (POKER_START(1,$Currenthand[0],$Currenthand[1],$Currenthand[2],$Currenthand[3],$Currenthand[4]));

	@NewResults = (POKER_LOGIC($Newhand[0],$Newhand[1],$Newhand[2],$Newhand[3],$Newhand[4],0));

	$Card1F = POKER_CARD_NAMES($NewResults[1]);
	$Card2F = POKER_CARD_NAMES($NewResults[2]);
	$Card3F = POKER_CARD_NAMES($NewResults[3]);
	$Card4F = POKER_CARD_NAMES($NewResults[4]);
	$Card5F = POKER_CARD_NAMES($NewResults[5]);


	 @DealerHand = (POKER_START(2,0,0,0,0,0));

	 @DealerResults = (POKER_LOGIC($DealerHand[0],$DealerHand[1],$DealerHand[2],$DealerHand[3],$DealerHand[4],1));

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

	 #quest::popup("Results", "$intro </c> <br><br> $Yel $TextToCenter2 </c><br><br> $Yel $TextToCenter3 </c><br><br> $Yel $TextToCenter4 </c><br><br> $Yel $TextToCenter5 </c> <br><br> $Yel $TextToCenter6");



	 $Card1FD = POKER_CARD_NAMES($DealerResults[1]);
	$Card2FD = POKER_CARD_NAMES($DealerResults[2]);
	$Card3FD = POKER_CARD_NAMES($DealerResults[3]);
	$Card4FD = POKER_CARD_NAMES($DealerResults[4]);
	$Card5FD = POKER_CARD_NAMES($DealerResults[5]);

	 $Outcome = POKER_DEALER_V_PLAYER($NewResults[0], $DealerResults[0],$NewResults[6],$DealerResults[6]);

	quest::say($NewResults[0].', '."[$Card1F]".', '."[$Card2F]".', '."[$Card3F]".', '."[$Card4F]".', '."[$Card5F]");
	quest::say($DealerResults[0].', '."[$Card1FD]".', '."[$Card2FD]".', '."[$Card3FD]".', '."[$Card4FD]".', '."[$Card5FD]");
	quest::say($Outcome);


	$UIProgression = 0;
	$MoneyCheck = 0;
      }
}

sub EVENT_ITEM {

	 $total = ($platinum * 1000) + ($gold * 100) + ($silver * 10) + $copper;

   	if($layer > 5){RouletteCheck();
	getChange();
  plugin::return_items(\%itemcount);}

	#return any unused money
 if($BeginPoker == 1)
 {
	if($total > 0)
	{
		$MoneyCheck = 1;
	    $copper_return = $total % 10;
		$total = (($total - $copper_return)/10);
		$silver_return= $total % 10;
		$total = (($total - $silver_return)/10);
		$gold_return = $total % 10;
		$total = (($total - $gold_return)/10);

		 my $intro = "Thank you for your bet, you can start playing!";


	 my $Indent = plugin::PWIndent();
	 my $Yel = plugin::PWColor("Yellow");
	 my $Blu = plugin::PWColor("Light Blue");
	 my $Red = plugin::PWColor("Red");
	 my $grn = plugin::PWColor("Forest Green");


	  my $dialogMessage = "{title: Curernt Hand} {button_one: Stop} {button_two: Play} wintype:1 $intro </c> <br><br>";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
 }
}
}
