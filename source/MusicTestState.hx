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

class MusicTestState extends FlxState
{
	public static var curSelected:Int = 0;
	var click:FlxSound;
	var vignette:FlxSprite;
	var bleck:FlxSprite;
	var musicList:FlxTypedGroup<FlxText>;
	var musicShit:Array<String> = [
		"empty_ambience"
	];
	var musicTitles:Array<String> = [
		"Menu Ambience"
	];
	var canSelect:Bool = false;

	override public function create()
	{
		FlxG.sound.music.stop(); // just in case lol

		click = FlxG.sound.load(AssetPaths.enter_sound__ogg);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.GRAY);
		bg.screenCenter();
		add(bg);

		musicList = new FlxTypedGroup<FlxText>();
		add(musicList);

		for (i in 0...musicShit.length)
		{
			var musicTxt:FlxText = new FlxText(0, 45 + (i * 75), FlxG.width, "", 25);
			musicTxt.setFormat(AssetPaths.CascadiaCodePL_Regular__ttf, 25, FlxColor.WHITE, CENTER);
			musicTxt.alpha = 0.65;
			musicTxt.text = musicTitles[i];
			musicTxt.ID = i;
			musicList.add(musicTxt);
			musicTxt.updateHitbox();
		}

		vignette = new FlxSprite().loadGraphic(AssetPaths.vignette__png);
		vignette.setGraphicSize(Std.int(vignette.width * 1.5));
		vignette.screenCenter();
		vignette.antialiasing = true;
		add(vignette);

		bleck = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bleck.screenCenter();
		add(bleck);

		super.create();

		FlxTween.tween(vignette, {alpha: 0.45}, 1.1, {ease: FlxEase.quartInOut});
		FlxTween.tween(bleck, {alpha: 0.45}, 1.1, {ease: FlxEase.quartInOut});
		new FlxTimer().start(1.1, function(tmr:FlxTimer) {
			canSelect = true;
		});
	}

	var selectedSmth:Bool = false;

	override public function update(elapsed:Float)
	{
		if (canSelect && !selectedSmth)
		{
			if (FlxG.keys.justPressed.BACKSPACE) {
				click.play();
				selectedSmth = true;
				returnToSoundTest();
			}
		}

		super.update(elapsed);
	}

	function returnToSoundTest()
	{
		FlxTween.tween(vignette, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});
		FlxTween.tween(bleck, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});
		new FlxTimer().start(1.1, function(tmr:FlxTimer) {
			FlxG.switchState(new SoundTestState());
		});
	}
}
