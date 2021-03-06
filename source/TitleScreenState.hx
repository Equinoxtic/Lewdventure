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
	var white:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
	var bleck:FlxSprite;
	var vignette:FlxSprite;
	// var ambience:FlxSound;
	var enterSound:FlxSound;
	var titletxt:FlxText;
	var pressEnter:FlxText;
	// var camAlphaTwn:FlxTween;
	// var vignetteTwn:FlxTween;
	var bleckTwn:FlxTween;
	var transparencyVal:Float = 0.45;
	var canSelect:Bool = false;

	override public function create()
	{
		enterSound = FlxG.sound.load(AssetPaths.title_confirm__ogg);

		if (FlxG.sound.music == null) {
			FlxG.sound.playMusic(AssetPaths.empty_ambience__ogg);
		}

		titletxt = new FlxText(0, 0, 0, "Lewdventure", 50);
		titletxt.screenCenter();
		add(titletxt);

		pressEnter = new FlxText(0, titletxt.y + 75, "Press Enter", 20);
		pressEnter.screenCenter(X);
		add(pressEnter);

		add(white);
		white.alpha = 0;

		vignette = new FlxSprite().loadGraphic("assets/images/vignette.png");
		vignette.setGraphicSize(Std.int(vignette.width * 1.5));
		vignette.antialiasing = true;
		vignette.screenCenter();
		add(vignette);

		bleck = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bleck.screenCenter();
		add(bleck);

		super.create();

		/*
		FlxG.camera.alpha = 0;
		camAlphaTwn = FlxTween.tween(FlxG.camera, {alpha: 1}, 3.5, {onComplete: function(twn:FlxTween) {
			canSelect = true;
		}});
		*/

		FlxTween.tween(vignette, {alpha: transparencyVal}, 1.35);
		bleckTwn = FlxTween.tween(bleck, {alpha: transparencyVal}, 1.35, {onComplete: function(twn:FlxTween) {
			canSelect = true;
		}});

		/*
		vignetteTwn = FlxTween.tween(vignette, {alpha: transparencyVal}, 3.5, {onComplete: function(twn:FlxTween) {
			canSelect = true;
		}});
		*/
	}

	var selectedSmth:Bool = false;

	override public function update(elapsed:Float)
	{
		if (canSelect && !selectedSmth) {
			if (FlxG.keys.justPressed.ENTER) {
				selectedSmth = true;
				enterSound.play();
				pulse(0.85);
				FlxTween.tween(bleck, {alpha: 1}, bleckTwn.duration);
				FlxTween.tween(vignette, {alpha: 1}, bleckTwn.duration);
				new FlxTimer().start(bleckTwn.duration, function(tmr:FlxTimer) {
					FlxG.switchState(new MainMenuState());
				});
			}
		}
		super.update(elapsed);
	}

	function pulse(initalpha:Float)
	{
		white.screenCenter();
		white.alpha = initalpha;
		FlxTween.tween(white, {alpha: 0}, 1.1, {ease: FlxEase.quartInOut});
	}
}
