package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.system.FlxSound;

using StringTools;

class MainMenuState extends FlxState
{
	var bg:FlxSprite;
	var sidebar:FlxSprite;
	var canSelect:Bool = false;
	var camAlphaTwn:FlxTween;
	override public function create()
	{
		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.GRAY);
		bg.screenCenter();
		add(bg);

		sidebar = new FlxSprite().makeGraphic(10, FlxG.height, FlxColor.BLACK);
		// sidebar.x = FlxG.width * 2;
		sidebar.screenCenter();
		add(sidebar);

		super.create();

		FlxG.camera.alpha = 0;

		camAlphaTwn = FlxTween.tween(FlxG.camera, {alpha: 1}, 3.5, {onComplete: function(twn:FlxTween) {
			canSelect = true;
		}});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
