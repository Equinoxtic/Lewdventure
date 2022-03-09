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
	var vignette:FlxSprite;
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

		pressEnter = new FlxText(0, titletxt.y + 35, "Press Enter", 20);
		pressEnter.screenCenter(X);
		add(pressEnter);

		vignette = new FlxSprite().loadGraphic("assets/images/vignette.png");
		vignette.setGraphicSize(Std.int(vignette.width * 1.5));
		vignette.antialiasing = true;
		add(vignette);

		super.create();

		FlxG.camera.alpha = 0;

		FlxTween.tween(vignette, {alpha: 0.75}, 3.5);
		camAlphaTwn = FlxTween.tween(FlxG.camera, {alpha: 1}, 3.5, {onComplete: function(twn:FlxTween) {
			canSelect = true;
		}});
	}

	override public function update(elapsed:Float)
	{
		if (canSelect) {
			if (FlxG.keys.justPressed.ENTER) {
				enterSound.play();
				FlxTween.tween(vignette, {alpha: 0}, 3.5);
				FlxTween.tween(FlxG.camera, {alpha: 0}, camAlphaTwn.duration);
				new FlxTimer().start(camAlphaTwn.duration, function(tmr:FlxTimer) {
					FlxG.switchState(new MainMenuState());
				});
			}
		}
		super.update(elapsed);
	}
}
