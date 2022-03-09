package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.system.FlxSound;

using StringTools;

class TitleScreenState extends FlxState
{
	var bleck:FlxSprite;
	var vignette:FlxSprite;
	// var ambience:FlxSound;
	var enterSound:FlxSound;
	var titletxt:FlxText;
	var pressEnter:FlxText;
	// var camAlphaTwn:FlxTween;
	// var vignetteTwn:FlxTween;
	var bleckTwn:FlxTween;
	var transparencyVal:Float = 0.65;
	var canSelect:Bool = false;
	var mouseVisible:Bool = true;
	override public function create()
	{
		if (FlxG.mouse.visible) {
			FlxG.mouse.visible = !mouseVisible;
		} else {
			FlxG.mouse.visible = mouseVisible;
		}

		enterSound = FlxG.sound.load(AssetPaths.enter_sound__ogg);

		if (FlxG.sound.music == null) {
			FlxG.sound.playMusic(AssetPaths.empty_ambience__ogg);
		}

		titletxt = new FlxText(0, 0, 0, "Lewdventure", 50);
		titletxt.screenCenter();
		add(titletxt);

		pressEnter = new FlxText(0, titletxt.y + 75, "Press Enter", 20);
		pressEnter.screenCenter(X);
		add(pressEnter);

		bleck = new FlxSprite().makeGraphic(FlxG.height, FlxG.width, FlxColor.BLACK);
		bleck.screenCenter();
		add(bleck);

		super.create();

		/*
		FlxG.camera.alpha = 0;
		camAlphaTwn = FlxTween.tween(FlxG.camera, {alpha: 1}, 3.5, {onComplete: function(twn:FlxTween) {
			canSelect = true;
		}});
		*/

		bleckTwn = FlxTween.tween(bleck, {alpha: transparencyVal}, 3.5, {onComplete: function(twn:FlxTween) {
			canSelect = true;
		}});
		/*
		vignetteTwn = FlxTween.tween(vignette, {alpha: transparencyVal}, 3.5, {onComplete: function(twn:FlxTween) {
			canSelect = true;
		}});
		*/
	}

	override public function update(elapsed:Float)
	{
		if (canSelect) {
			if (FlxG.keys.justPressed.ENTER) {
				enterSound.play();
				FlxTween.tween(bleck, {alpha: 1}, bleckTwn.duration);
				new FlxTimer().start(vignetteTwn.duration, function(tmr:FlxTimer) {
					FlxG.switchState(new MainMenuState());
				});
			}
		}
		super.update(elapsed);
	}
}
