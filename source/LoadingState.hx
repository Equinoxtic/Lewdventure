package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

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

		var loadCube:FlxSprite = new FlxSprite().makeGraphic(2, 2, FlxColor.WHITE);
		loadCube.screenCenter();
		add(loadCube);

		super.create();

		FlxTween.tween(loadCube, {angle: 360}, 1.7, {ease: FlxEase.quartInOut, type: FlxTweenType.PINGPONG});
	}

	override public function update(elapsed:Float) 
	{
		super.update(elapsed);
	}
}
