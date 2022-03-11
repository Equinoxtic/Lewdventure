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
import LevelSelectionState;

using StringTools;

class ChapterSelectionState extends FlxState
{
	public static var curSelected:Int = 0;
	var vignette:FlxSprite;
	var blackShit:FlxSprite;
	var vignetteTwn:FlxTween;
	var blackShitTwn:FlxTween;
	var clickSound:FlxSound;

	var chapterList:FlxTypedGroup<FlxSprite>;
	var chapterShit:Array<String> = [
		"limbo"
	];
	
	var chapterText:FlxTypedGroup<FlxText>;
	var chapterTextShit:Array<String> = [
		"Limbo"
	];

	var canSelect:Bool = false;

	override public function create()
	{
		clickSound = FlxG.sound.load(AssetPaths.enter_sound__ogg);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.GRAY);
		bg.screenCenter();
		add(bg);
		
		chapterList = new FlxTypedGroup<FlxSprite>();
		add(chapterList);

		chapterText = new FlxTypedGroup<FlxText>();
		add(chapterText);

		for (i in 0...chapterShit.length)
		{
			var chapters:FlxSprite = new FlxSprite((i * 20), 0).loadGraphic("assets/images/chapters/chapter_" + chapterShit[i] + ".png");
			chapters.setGraphicSize(Std.int(chapters.width * 0.75));
			chapters.alpha = 0.65;
			chapters.antialiasing = true;
			chapters.ID = i;
			chapterList.add(chapters);
			chapters.updateHitbox();

			var theText:FlxText = new FlxText((i * 20), chapters.y - 50, FlxG.width, "", 30);
			theText.setFormat(AssetPaths.CascadiaCodePL_Regular__ttf, 30, FlxColor.WHITE, CENTER);
			theText.alpha = 0.65;
			theText.text = chapterTextShit[i];
			theText.ID = i;
			chapterText.add(theText);
			theText.updateHitbox();
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

		vignetteTwn = FlxTween.tween(vignette, {alpha: 0.45}, 1.1, {ease: FlxEase.quartInOut});
		blackShitTwn = FlxTween.tween(blackShit, {alpha: 0.45}, 1.1, {ease: FlxEase.quartInOut});
		new FlxTimer().start(vignetteTwn.duration, function(tmr:FlxTimer) {
			canSelect = true;
		});
	}

	var selected:Bool = false;

	override public function update(elapsed:Float)
	{
		if (canSelect)
		{
			if (FlxG.keys.justPressed.BACKSPACE) {
				selected = true;
				clickSound.play();
				returnToMainMenu();
			}

			if (FlxG.keys.justPressed.UP) {
				selected = true;
				clickSound.play();
				doDaScroll(-1);
			}

			if (FlxG.keys.justPressed.DOWN) {
				selected = true;
				clickSound.play();
				doDaScroll(1);
			}

			if (FlxG.keys.justPressed.ENTER)
			{
				selected = true;
				clickSound.play();
				FlxTween.tween(blackShit, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});
				FlxTween.tween(vignette, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});
				chapterList.forEach(function(spr:FlxSprite) {
					if (curSelected == spr.ID) {
						var chapter:String = chapterShit[curSelected];
						goToChapter(chapter, 1.1);
					}
				});
			}
			else
			{
				chapterList.forEach(function(spr:FlxSprite) {
					if (spr.ID != curSelected) {
						spr.alpha = 0.65;
					} else {
						spr.alpha = 1;
					}
				});
				chapterText.forEach(function(txt:FlxText) {
					if (txt.ID != curSelected) {
						txt.alpha = 0.65;
					} else {
						txt.alpha = 1;
					}
				});
			}
		}

		super.update(elapsed);

		chapterList.forEach(function(spr:FlxSprite) {
			spr.screenCenter();
		});
	}

	function goToChapter(chapter:String, time:Float) {
		new FlxTimer().start(time, function(tmr:FlxTimer) {
			switch(chapter) {
				case 'limbo':
					LevelSelectionState.currentChapter = 'limbo';
					FlxG.switchState(new LevelSelectionState());
			}
		});
	}

	function doDaScroll(a:Int=0)
	{
		curSelected += a;
		if (curSelected >= chapterList.length) {
			curSelected = 0;
		}
		if (curSelected < 0) {
			curSelected = chapterList.length - 1;
		}
		chapterList.forEach(function(spr:FlxSprite) {
			spr.updateHitbox();
			if (spr.ID == curSelected) {
				var add:Float = 0;
				if (chapterList.length > 4) {
					add = chapterList.length * 1;
				}
			}
		});
	}

	function returnToMainMenu()
	{
		clickSound.play();
		FlxTween.tween(vignette, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});
		FlxTween.tween(blackShit, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});
		new FlxTimer().start(1.1, function(tmr:FlxTimer) {
			FlxG.switchState(new MainMenuState());
		});
	}
}
