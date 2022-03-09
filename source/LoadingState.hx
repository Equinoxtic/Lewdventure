package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.text.FlxText;
using StringTools;

class LoadingState extends FlxState
{
	var werningTxt:FlxText;

	override public function create() 
	{
		werningTxt = new FlxText(0, 0, 0, "", 15);
		werningTxt.text = "WARNING\n" + "This game contains sexual and mature content.\n" + "Play it in a dark room all alone, and without your parents around you.\n" + "Enjoy the game, cupcake ;)";
		werningTxt.screenCenter();
		add(werningTxt);

		super.create();
	}

	override public function update(elapsed:Float) 
	{
		super.update(elapsed);
	}
}
