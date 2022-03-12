package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.system.FlxSound;
import flixel.group.FlxGroup.FlxTypedGroup;

using StringTools;

class SoundTestState extends FlxState
{
	public static var curSelected:Int = 0;
	var clickSound:FlxSound;
	var bg:FlxSprite;
	var vignette:FlxSprite;
	var blackShit:FlxSprite;
	var soundTestSongs:FlxTypedGroup<FlxText>;
	var stShit:Array<String> = [];
	var stNames:Array<String> = [];
	var canSelect:Bool = false;

	override function create()
	{
		FlxG.sound.music.stop();

		clickSound = FlxG.sound.load(AssetPaths.enter_sound__ogg);

		soundTestSongs = new FlxTypedGroup<FlxText>();
		add(soundTestSongs);

		for (i in 0...stShit.length)
		{
			var daContents:FlxText = new FlxText(0, 100 + (i * 20), FlxG.width, "", 20);
			daContents.setFormat(AssetPaths.CascadiaCodePL_Regular__ttf, 20, FlxColor.WHITE, CENTER);
			daContents.alpha = 0.65;
			daContents.text = stNames[i];
			daContents.ID = i;
			soundTestSongs.add(daContents);
			daContents.updateHitbox();
		}

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.GRAY);
		bg.screenCenter();
		add(bg);

		vignette = new FlxSprite().loadGraphic("assets/images/vignette.png");
		vignette.setGraphicSize(Std.int(vignette.width * 1.5));
		vignette.screenCenter();
		vignette.antialiasing = true;
		add(vignette);

		blackShit = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackShit.screenCenter();
		add(blackShit);

		super.create();

		FlxTween.tween(vignette, {alpha: 0.45}, 1.1, {ease: FlxEase.quartInOut});
		FlxTween.tween(blackShit, {alpha: 0.45}, 1.1, {ease: FlxEase.quartInOut});
		new FlxTimer().start(1.1, function(tmr:FlxTimer) {
			canSelect = true;
		});
	}

	var selectedSmth:Bool = false;

	override function update(elapsed:Float)
	{
		if (canSelect && !selectedSmth)
		{
			if (FlxG.keys.justPressed.BACKSPACE) {
				clickSound.play();
				selectedSmth = true;
				returnToMainMenu();
			}
		}

		super.update(elapsed);

		soundTestSongs.forEach(function(txt:FlxText) {
			txt.screenCenter(X);
		});
	}

	function returnToMainMenu()
	{
		FlxTween.tween(vignette, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});
		FlxTween.tween(blackShit, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});
		new FlxTimer().start(1.1, function(tmr:FlxTimer) {
			FlxG.switchState(new MainMenuState());
		});
	}
}
