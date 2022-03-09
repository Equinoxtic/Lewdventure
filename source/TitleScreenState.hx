package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.system.FlxSound;

using StringTools;

class TitleScreenState extends FlxState
{
	// var ambience:FlxSound;
	var enterSound:FlxSound;
	var titletxt:FlxText;
	var pressEnter:FlxText;
	var camAlphaTwn:FlxTween;
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

		titletxt = new FlxText(0, 0, 0, "Lewd Haxe", 35);
		titletxt.screenCenter();
		add(titletxt);

		pressEnter = new FlxText(0, titletxt.y + 25, "Press Enter", 20);
		pressEnter.screenCenter(X);
		add(pressEnter);

		super.create();

		FlxG.camera.alpha = 0;

		camAlphaTwn = FlxTween.tween(FlxG.camera, {alpha: 1}, 3.5, {onComplete: function(twn:FlxTween) {
			canSelect = true;
		}});
	}

	override public function update(elapsed:Float)
	{
		if (canSelect) {
			if (FlxG.keys.justPressed.ENTER) {
				canSelect = false;
				enterSound.play();
				FlxTween.tween(FlxG.camera, {alpha: 0}, camAlphaTwn.duration);
				new FlxTimer().start(camAlphaTwn.duration, function(tmr:FlxTimer) {
					FlxG.switchState(new MainMenuState());
				});
			}
		} else {
			trace("Cannot Press.");
		}
		super.update(elapsed);
	}
}
