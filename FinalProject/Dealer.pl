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
		quest::say("This game is currently closed");
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