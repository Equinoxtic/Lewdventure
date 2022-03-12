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
	public static var fromSoundTest:Bool = false;
	public static var curSelected:Int = 0;
	var click:FlxSound;
	var vignette:FlxSprite;
	var bleck:FlxSprite;
	var musicList:FlxTypedGroup<FlxText>;
	var musicShit:Array<String> = [
		"empty_ambience",
		"back"
	];
	var musicTitles:Array<String> = [
		"Menu Ambience",
		"Back"
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
			musicTxt.setFormat("assets/fonts/CascadiaCodePL-Regular.ttf", 25, FlxColor.WHITE, LEFT);
			musicTxt.alpha = 0.65;
			musicTxt.text = musicTitles[i];
			musicTxt.ID = i;
			musicList.add(musicTxt);
			musicTxt.updateHitbox();
		}

		vignette = new FlxSprite().loadGraphic("assets/images/vignette.png");
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
			if (FlxG.keys.justPressed.UP) {
				click.play();
				changeDaItem(-1);
			}

			if (FlxG.keys.justPressed.DOWN) {
				click.play();
				changeDaItem(1);
			}

			/*
			if (FlxG.keys.justPressed.BACKSPACE) {
				click.play();
				selectedSmth = true;
				returnToSoundTest();
			}
			*/

			if (FlxG.keys.justPressed.ENTER)
			{
				click.play();
				if (musicShit[curSelected] == 'back') {
					returnToState();
				} else {
					var music:String = musicShit[curSelected];
					playMoosic(music);
				}
			}
		}

		musicList.forEach(function(txt:FlxText) {
			if (txt.ID != curSelected) {
				txt.alpha = 0.65;
			} else {
				txt.alpha = 1;
			}
		});

		super.update(elapsed);

		musicList.forEach(function(txt:FlxText) {
			txt.x = 100;
		});
	}

	function playMoosic(moosic:String) {
		FlxG.sound.playMusic("assets/music/" + moosic + ".ogg");
	}

	function changeDaItem(iwhat:Int=0) {
		curSelected += iwhat;
		if (curSelected >= musicList.length) {
			curSelected = 0;
		}
		if (curSelected < 0) {
			curSelected = musicList.length - 1;
		}
		musicList.forEach(function(txt:FlxText) {
			txt.updateHitbox();
			if (txt.ID == curSelected) {
				var add:Float = 0;
				if (musicList.length > 4) {
					add = musicList.length * 2;
				}
			}
		});
	}

	function returnToState()
	{
		FlxTween.tween(vignette, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});
		FlxTween.tween(bleck, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});
		new FlxTimer().start(1.1, function(tmr:FlxTimer) {
			if (fromSoundTest) {
				FlxG.switchState(new SoundTestState());
			} else {
				FlxG.switchState(new MainMenuState());
			}
		});
	}
}
