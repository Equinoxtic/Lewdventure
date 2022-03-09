package;

import flixel.util.FlxTimer;
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
	var blackshit:FlxSprite;
	var vignette:FlxSprite;
	var blackshittwn:FlxTween;
	var vignettetwn:FlxTween;
	var canSelect:Bool = false;
	// var camAlphaTwn:FlxTween;
	override public function create()
	{
		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.GRAY);
		bg.screenCenter();
		add(bg);

		sidebar = new FlxSprite().makeGraphic(50, FlxG.height, FlxColor.BLACK);
		// sidebar.x = FlxG.width * 2;
		sidebar.screenCenter();
		add(sidebar);

		blackshit = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackshit.screenCenter();
		add(blackshit);

		vignette = new FlxSprite().loadGraphic("assets/images/vignette.png");
		vignette.setGraphicSize(Std.int(vignette.width * 1.5));
		vignette.screenCenter();
		vignette.antialiasing = true;
		add(vignette);

		super.create();

		/* Old shit :troll:
		FlxG.camera.alpha = 0;
		camAlphaTwn = FlxTween.tween(FlxG.camera, {alpha: 1}, 3.5, {onComplete: function(twn:FlxTween) {
			canSelect = true;
		}});
		*/

	 	blackshittwn = FlxTween.tween(blackshit, {alpha: 0.45}, 2.85, {ease: FlxEase.quartInOut});
		vignettetwn = FlxTween.tween(vignette, {alpha: 0.45}, 2.35, {ease: FlxEase.quartInOut});
		new FlxTimer().start(blackshittwn.duration, function(tmr:FlxTimer) {
			canSelect = true;
		});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
