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
import PlayState;

using StringTools;

class LevelSelectionState extends FlxState
{
	public static var curSelected:Int = 0;
	var clickSound:FlxSound;
	var vignette:FlxSprite;
	var blackShit:FlxSprite;
	var vignetteTwn:FlxTween;
	var blackShitTwn:FlxTween;

	var lvlList:FlxTypedGroup<FlxSprite>;
	var lvlShit:Array<String> = [
		"demo",
		"test"
	];

	var lvlTitleList:FlxTypedGroup<FlxText>;
	var lvlTitleShit:Array<String> = [
		"Demo",
		"Test"
	];

	public static var currentChapter:String = "";
	var chapterPrefix:String = "";
	var canSelect:Bool = false;
	
	override public function create()
	{
		clickSound = FlxG.sound.load(AssetPaths.enter_sound__ogg);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.GRAY);
		bg.screenCenter();
		add(bg);

		switch (currentChapter)
		{
			case "limbo":
				chapterPrefix = "first_chapter";
		}

		lvlList = new FlxTypedGroup<FlxSprite>();
		add(lvlList);

		lvlTitleList = new FlxTypedGroup<FlxText>();
		add(lvlTitleList);

		for (i in 0...lvlShit.length)
		{
			var lvlThumbnails:FlxSprite = new FlxSprite(0, 75 + (i * 405)).loadGraphic("assets/images/levels/" + chapterPrefix + "/level_" + lvlShit[i] + ".png");
			lvlThumbnails.setGraphicSize(Std.int(lvlThumbnails.width * 0.75));
			lvlThumbnails.alpha = 0.65;
			lvlThumbnails.antialiasing = true;
			lvlThumbnails.ID = i;
			lvlList.add(lvlThumbnails);
			lvlThumbnails.updateHitbox();

			var lvlTitle:FlxText = new FlxText(0, lvlThumbnails.y - 45, FlxG.width, "", 30);
			lvlTitle.setFormat(AssetPaths.CascadiaCodePL_Regular__ttf, 30, FlxColor.WHITE, CENTER);
			lvlTitle.alpha = 0.65;
			lvlTitle.text = lvlTitleShit[i];
			lvlTitle.ID = i;
			lvlTitleList.add(lvlTitle);
			lvlTitle.updateHitbox();
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
		if (canSelect && !selectedSmth)
		{
			if (FlxG.keys.justPressed.UP) {
				clickSound.play();
				doDaScroll(-1);
			}

			if (FlxG.keys.justPressed.DOWN) {
				clickSound.play();
				doDaScroll(1);
			}

			if (FlxG.keys.justPressed.BACKSPACE) {
				clickSound.play();
				selectedSmth = true;
				returnToChapterSelect();
			}

			if (FlxG.keys.justPressed.ENTER)
			{
				selectedSmth = true;
				clickSound.play();
				FlxTween.tween(vignette, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});
				FlxTween.tween(blackShit, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});
				lvlList.forEach(function(spr:FlxSprite) {
					if (curSelected == spr.ID) {
						var level:String = lvlShit[curSelected];
						goToLevel(level, 1.1);
					}
				});
			}
		}

		super.update(elapsed);

		lvlList.forEach(function(spr:FlxSprite) {
			spr.screenCenter(X);
		});
	}

	function goToLevel(level:String, time:Float) {
		new FlxTimer().start(time, function(tmr:FlxTimer) {
			switch(level) {
				case 'demo':
					PlayState.currentLevel = 'demo';
			}
			FlxG.switchState(new PlayState());
		});
	}

	function doDaScroll(dawhat:Int=0)
	{
		curSelected += dawhat;
		if (curSelected >= lvlList.length) {
			curSelected = 0;
		}
		if (curSelected < 0) {
			curSelected = lvlList.length - 1;
		}
		lvlList.forEach(function(spr:FlxSprite) {
			if (spr.ID == curSelected) {
				var add:Float = 0;
				if (lvlList.length > 4) {
					add = lvlList.length * 1;
				}
				// spr.centerOffsets();
			}
		});
	}

	function returnToChapterSelect() {
		FlxTween.tween(vignette, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});
		FlxTween.tween(blackShit, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});
		new FlxTimer().start(1.1, function(tmr:FlxTimer) {
			FlxG.switchState(new ChapterSelectionState());
		});
	}
}
