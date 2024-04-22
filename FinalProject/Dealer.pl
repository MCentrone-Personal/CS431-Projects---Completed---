sub CARD_GENERATOR {
  return int(rand(36));
  # 		my $number = CARD_GENERATOR();
}

# Message event for NPC, right now responds to hail
sub EVENT_SAY {
    #:: Match say message for "hail", /i for case insensitive
    if ($text=~/hail/i){
     quest::say("Hello, $name!. Welcome to the [Golden Bull]");
    }
	
	if ($text=~/Golden Bull/i) {
		$games = 2;
		$gameSelect = 0;
	    $layer = 0;
		$RRP = 0;
		$boolean = 0;
		

	
		
       my $dialogMessage = "{title: Welcome} wintype:0 Welcome to the <c \"#FFD700\"> Golden Bull </c>";
      quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
    }		
}

our $games = 2;
our $gameSelect = 0;
our $layer = 0;
our $boolean = 0;

sub EVENT_POPUPRESPONSE {
		 if($popupid == 99999)
		 {
		    if($layer==0){PopUpChange();}
		    elsif($layer==2){BlackJackRules();}
			elsif($layer==3){Roulette();}
			elsif($layer==4){PokerRules();}
			elsif($layer==6 && $RRP > 3){RouletteBet();}
		 }
		 
		 if($popupid == 100000){
			
				if($layer == 6){$boolean = 1;}
			if($layer > 5){ $layer +=5;}
			elsif($layer >2 && $layer < 5) {$layer += $games +1;} 
			elsif($layer==0){$layer = $games + $gameSelect;}

		       if($layer==2){BlackJackRules();}
		    elsif($layer==3){Roulette();}
			elsif($layer==4){PokerRules();}
			elsif($layer==6){RouletteBet();}
			
		 }
		 
}

our $total;

sub EVENT_ITEM {

	$total = ($platinum * 1000) + ($gold * 100) + ($silver * 10) + $copper;
	
	if($layer > 5){RouletteCheck();}
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
	}
	
	elsif($gameSelect==1)
	{
		$gameSelect++;
		my $dialogMessage = "{title: POKER} {button_one: Change Game} {button_two: SELECT GAME} wintype:1 DANCE ON THEIR GRAVES";
        quest::crosszonedialoguewindowbycharid($client->CharacterID(), $dialogMessage);
	}
	
	elsif($gameSelect==2)
	{
		$gameSelect=0;
		my $dialogMessage = "{title: BLACKJACK} {button_one: Change Game} {button_two: SELECT GAME} wintype:1 ONLY THE CLUBS AND SPADES";
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

sub PokerRules()
{
	
}

sub BlackJackRules()
{
	
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
		my $dialogMessage = "{title: Results} wintype:0 <br> You bet on <c \"#00F0F0\"> Numbers </c> <br>";
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
	
