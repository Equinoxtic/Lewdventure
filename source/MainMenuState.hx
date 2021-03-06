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

class MainMenuState extends FlxState
{
	public static var curSelected:Int = 0;
	var bg:FlxSprite;
	// var sidebar:FlxSprite;
	var invis:FlxSprite;
	var blackshit:FlxSprite;
	var vignette:FlxSprite;
	var blackshittwn:FlxTween;
	var vignettetwn:FlxTween;
	var canSelect:Bool = false;
	// var camAlphaTwn:FlxTween;
	var clickSound:FlxSound;

	var menuIcons:FlxTypedGroup<FlxSprite>;
	var iconShit:Array<String> = [
		"play",
		"settings",
		"achievements",
		"github",
		"sound-test"
	];

	var menuTxt:FlxTypedGroup<FlxText>;
	var textShit:Array<String> = [
		"Play",
		"Settings",
		"Achievements",
		"GitHub Page",
		"Sound Test"
	];

	var daTxt:FlxText;

	override public function create()
	{
		// if (!FlxG.mouse.visible) {
		// 	FlxG.mouse.visible = true;
		// }

		clickSound = FlxG.sound.load(AssetPaths.enter_sound__ogg);

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.GRAY);
		bg.screenCenter();
		add(bg);

		menuIcons = new FlxTypedGroup<FlxSprite>();
		menuTxt = new FlxTypedGroup<FlxText>();
		add(menuIcons);
		add(menuTxt);

		for (i in 0...iconShit.length)
		{
			var icons:FlxSprite = new FlxSprite(0, 75 + (i * 75)).loadGraphic("assets/images/icons/icon_" + iconShit[i] + ".png");
			icons.setGraphicSize(Std.int(icons.width * 0.45));
			icons.antialiasing = true;
			icons.alpha = 0.65;
			icons.ID = i;
			menuIcons.add(icons);
			icons.updateHitbox();

			var daText:FlxText = new FlxText(0, 77 + (i * 75), FlxG.width, "", 25);
			daText.setFormat("assets/fonts/CascadiaCodePL-Regular.ttf", 25, FlxColor.WHITE, LEFT);
			daText.alpha = 0.65;
			daText.text = textShit[i];
			daText.ID = i;
			menuTxt.add(daText);
			daText.updateHitbox();
		}

		/*
		for (i in 0...textShit.length)
		{
			var daText:FlxText = new FlxText(0, (i * 75), FlxG.width, "", 25);
			daText.setFormat(AssetPaths.CascadiaCodePL_Regular__ttf, 25, FlxColor.WHITE, CENTER);
			daText.text = textShit[i];
			daText.ID = i;
			iconsText.add(daText);
			daText.updateHitbox();
		}
		*/

		vignette = new FlxSprite().loadGraphic("assets/images/vignette.png");
		vignette.setGraphicSize(Std.int(vignette.width * 1.5));
		vignette.screenCenter();
		vignette.antialiasing = true;
		add(vignette);

		blackshit = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackshit.screenCenter();
		add(blackshit);

		super.create();

		/* Old shit :troll:
		FlxG.camera.alpha = 0;
		camAlphaTwn = FlxTween.tween(FlxG.camera, {alpha: 1}, 3.5, {onComplete: function(twn:FlxTween) {
			canSelect = true;
		}});
		*/

	 	blackshittwn = FlxTween.tween(blackshit, {alpha: 0.45}, 1.85, {ease: FlxEase.quartInOut});
		vignettetwn = FlxTween.tween(vignette, {alpha: 0.45}, 1.85, {ease: FlxEase.quartInOut});
		new FlxTimer().start(blackshittwn.duration, function(tmr:FlxTimer) {
			canSelect = true;
		});
	}

	var selectedSmth:Bool = false;

	override public function update(elapsed:Float)
	{
		if (canSelect && !selectedSmth)
		{
			if (FlxG.keys.justPressed.M) {
				clickSound.play();
				selectedSmth = true;
				goToMusicTest();
			}

			if (FlxG.keys.justPressed.UP) {
				clickSound.play();
				changeItem(-1);
			}

			if (FlxG.keys.justPressed.DOWN) {
				clickSound.play();
				changeItem(1);
			}

			if (FlxG.keys.justPressed.BACKSPACE) {
				selectedSmth = true;
				clickSound.play();
				returnToTitle();
			}

			if (FlxG.keys.justPressed.ENTER)
			{
				if (iconShit[curSelected] == 'github')
				{
					var site:String = 'https://github.com/Equinoxtic/Lewdventure';
					#if linux
					Sys.command('/usr/bin/xdg-open', [site]);
					#else
					FlxG.openURL(site);
					#end
				}
				else
				{
					selectedSmth = true;

					clickSound.play();

					FlxTween.tween(blackshit, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});
					FlxTween.tween(vignette, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});

					menuIcons.forEach(function(spr:FlxSprite) {
						if (curSelected == spr.ID) {
							var choice:String = iconShit[curSelected];
							goToState(choice, 1.1);
						}
					});
				}
			}
		}

		menuIcons.forEach(function(spr:FlxSprite) {
			if (spr.ID != curSelected) {
				spr.alpha = 0.65;
			} else {
				spr.alpha = 1;
			}
		});

		menuTxt.forEach(function(txt:FlxText) {
			if (txt.ID != curSelected) {
				txt.alpha = 0.65;
			} else {
				txt.alpha = 1;
			}
		});

		super.update(elapsed);

		menuIcons.forEach(function(spr:FlxSprite) {
			spr.x = 50;
		});

		menuTxt.forEach(function(txt:FlxText) {
			txt.x = 100;
		});
	}

	function goToState(state:String, time:Float) {
		new FlxTimer().start(time, function(tmr:FlxTimer) {
			switch (state) {
				case 'play':
					FlxG.switchState(new ChapterSelectionState());
				case 'sound-test':
					FlxG.switchState(new SoundTestState());
			}
		});
	}

	function changeItem(num:Int=0) {
		curSelected += num;
		if (curSelected >= menuIcons.length) {
			curSelected = 0;
		}
		if (curSelected < 0) {
			curSelected = menuIcons.length - 1;
		}
		menuIcons.forEach(function(spr:FlxSprite) {
			spr.updateHitbox();
			if (spr.ID == curSelected) {
				var add:Float = 0;
				if (menuIcons.length > 4) {
					add = menuIcons.length * 7;
				}
				// spr.centerOffsets(); Does it matter? :troll:
			}
		});
	}

	function returnToTitle()
	{
		clickSound.play();
		FlxTween.tween(blackshit, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});
		FlxTween.tween(vignette, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});
		new FlxTimer().start(1.1, function(tmr:FlxTimer) {
			FlxG.switchState(new TitleScreenState());
		});
	}

	function goToMusicTest()
	{
		FlxTween.tween(blackshit, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});
		FlxTween.tween(vignette, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});
		new FlxTimer().start(1.1, function(tmr:FlxTimer) {
			MusicTestState.fromSoundTest = false;
			FlxG.switchState(new MusicTestState());
		});
	}
}
