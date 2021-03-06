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
		"limbo",
		"test"
	];
	
	var chapterText:FlxTypedGroup<FlxText>;
	var chapterTextShit:Array<String> = [
		"Limbo",
		"Test"
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
			var chapters:FlxSprite = new FlxSprite(0, 0).loadGraphic("assets/images/chapters/chapter_" + chapterShit[i] + ".png");
			chapters.setGraphicSize(Std.int(chapters.width * 0.75));
			chapters.alpha = 0;
			chapters.antialiasing = true;
			chapters.ID = i;
			chapterList.add(chapters);
			chapters.updateHitbox();

			var theText:FlxText = new FlxText(0, chapters.y + 45, FlxG.width, "", 30);
			theText.setFormat("assets/fonts/CascadiaCodePL-Regular.ttf", 30, FlxColor.WHITE, LEFT);
			theText.alpha = 0;
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

	var selectedSmth:Bool = false;

	override public function update(elapsed:Float)
	{
		if (canSelect)
		{
			if (FlxG.keys.justPressed.LEFT) {
				clickSound.play();
				// doDaScroll(-1);
				wot('left');
			}

			if (FlxG.keys.justPressed.RIGHT) {
				clickSound.play();
				// doDaScroll(1);
				wot('right');
			}

			if (FlxG.keys.justPressed.BACKSPACE) {
				selectedSmth = true;
				clickSound.play();
				returnToMainMenu();
			}

			if (FlxG.keys.justPressed.ENTER)
			{
				selectedSmth = true;
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
		}

		chapterList.forEach(function(spr:FlxSprite) {
			if (spr.ID != curSelected) {
				spr.alpha = 0;
			} else {
				spr.alpha = 1;
			}
		});

		chapterText.forEach(function(txt:FlxText)
		{
			if (txt.ID != curSelected) {
				txt.alpha = 0;
			} else {
				txt.alpha = 1;
			}
		});

		super.update(elapsed);

		chapterList.forEach(function(spr:FlxSprite) {
			spr.screenCenter();
		});

		chapterText.forEach(function(txt:FlxText) {
			txt.x = 100;
		});
	}

	function goToChapter(chapter:String, time:Float) {
		new FlxTimer().start(time, function(tmr:FlxTimer) {
			switch(chapter) {
				case 'limbo':
					LevelSelectionState.currentChapter = 'limbo';
			}
			FlxG.switchState(new LevelSelectionState());
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
				// spr.centerOffsets();
			}
		});
	}

	function wot(scrolldirect:String)
	{
		canSelect = false;
		FlxTween.tween(vignette, {alpha: 1}, 0.8, {ease: FlxEase.expoOut});
		FlxTween.tween(blackShit, {alpha: 1}, 0.8, {ease: FlxEase.expoOut});
		new FlxTimer().start(0.8, function(tmr:FlxTimer) {
			canSelect = true;
			FlxTween.tween(vignette, {alpha: 0.45}, 0.8, {ease: FlxEase.expoOut});
			FlxTween.tween(blackShit, {alpha: 0.45}, 0.8, {ease: FlxEase.expoOut});
			switch(scrolldirect) {
				case 'left':
					doDaScroll(-1);
				case 'right':
					doDaScroll(1);
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
