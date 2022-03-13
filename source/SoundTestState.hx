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
import MusicTestState;

using StringTools;

class SoundTestState extends FlxState
{
	public static var curSelected:Int = 0;
	var clickSound:FlxSound;
	var bg:FlxSprite;
	var vignette:FlxSprite;
	var blackShit:FlxSprite;
	var soundTestSongs:FlxTypedGroup<FlxText>;
	var stShit:Array<String> = [
		"animoo_moan",
		"title_confirm",
		"enter_sound",
		"music-test"
	];
	var stNames:Array<String> = [
		"Moan",
		"Title Enter",
		"Click Sound 1",
		"Music Test"
	];
	var canSelect:Bool = false;

	override function create()
	{
		clickSound = FlxG.sound.load(AssetPaths.enter_sound__ogg);

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.GRAY);
		bg.screenCenter();
		add(bg);

		soundTestSongs = new FlxTypedGroup<FlxText>();
		add(soundTestSongs);

		for (i in 0...stShit.length)
		{
			var daContents:FlxText = new FlxText(0, 45 + (i * 75), FlxG.width, "", 25);
			daContents.setFormat("assets/fonts/CascadiaCodePL-Regular.ttf", 25, FlxColor.WHITE, LEFT);
			daContents.alpha = 0.65;
			daContents.text = stNames[i];
			daContents.ID = i;
			soundTestSongs.add(daContents);
			daContents.updateHitbox();
		}

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
			if (FlxG.keys.justPressed.UP) {
				doLeScroll(-1);
			}

			if (FlxG.keys.justPressed.DOWN) {
				doLeScroll(1);
			}

			if (FlxG.keys.justPressed.BACKSPACE) {
				clickSound.play();
				selectedSmth = true;
				goToState('main-menu');
			}

			if (FlxG.keys.justPressed.ENTER)
			{
				if (stShit[curSelected] == 'music-test') {
					goToState('music-test');
				} else {
					var sound:String = stShit[curSelected];
					playDaSound(sound);
				}
			}
		}

		soundTestSongs.forEach(function(txt:FlxText) {
			if (txt.ID != curSelected) {
				txt.alpha = 0.65;
			} else {
				txt.alpha = 1;
			}
		});

		super.update(elapsed);

		soundTestSongs.forEach(function(txt:FlxText) {
			txt.x = 100;
		});
	}

	function playDaSound(sound:String) {
		FlxG.sound.play("assets/sounds/" + sound + ".ogg");
	}

	function doLeScroll(x:Int=0)
	{
		curSelected += x;
		if (curSelected >= soundTestSongs.length) {
			curSelected = 0;
		}
		if (curSelected < 0) {
			curSelected = soundTestSongs.length - 1;
		}
		soundTestSongs.forEach(function(txt:FlxText) {
			txt.updateHitbox();
			if (txt.ID == curSelected) {
				var add:Float = 0;
				if (soundTestSongs.length > 4) {
					add = soundTestSongs.length * 4;
				}
			}
		});
	}

	function goToState(state:String)
	{
		FlxTween.tween(vignette, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});
		FlxTween.tween(blackShit, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});
		new FlxTimer().start(1.15, function(tmr:FlxTimer) {
			switch(state) {
				case 'music-test':
					MusicTestState.fromSoundTest = true;
					FlxG.switchState(new MusicTestState());
				case 'main-menu':
					FlxG.switchState(new MainMenuState());
			}
		});
	}
}
