package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.group.FlxGroup.FlxTypedGroup;

using StringTools;

class LevelSelectionState extends FlxState
{
	var vignette:FlxSprite;
	var blackShit:FlxSprite;
	var vignetteTwn:FlxTween;
	var blackShitTwn:FlxTween;
	var lvlList:FlxTypedGroup<FlxSprite>;
	var lvlShit:Array<String> = [
		"demo"
	];
	public static var currentChapter:String = "";
	var chapterPrefix:String = "";
	var canSelect:Bool = false;
	
	override public function create()
	{
		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.GRAY);
		bg.screenCenter();
		add(bg);

		lvlList = new FlxTypedGroup<FlxSprite>();
		add(lvlList);

		switch (currentChapter)
		{
			case "limbo":
				chapterPrefix = "first_chapter";
		}

		for (i in 0...lvlShit.length)
		{
			var lvlThumbnails:FlxSprite = new FlxSprite();
			lvlThumbnails.loadGraphic("assets/images/levels/" + chapterPrefix + "/level_" + lvlShit[i] + ".png");
			lvlThumbnails.setGraphicSize(Std.int(lvlThumbnails.width * 0.75));
			lvlThumbnails.antialiasing = true;
			lvlThumbnails.ID = i;
			lvlList.add(lvlThumbnails);
			lvlThumbnails.updateHitbox();
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

		vignetteTwn = FlxTween.tween(vignette, {alpha: 0.45}, 2.85, {ease: FlxEase.quartInOut});
		blackShitTwn = FlxTween.tween(blackShit, {alpha: 0.45}, 2.85, {ease: FlxEase.quartInOut});
		new FlxTimer().start(vignetteTwn.duration, function(tmr:FlxTimer) {
			canSelect = true;
		});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		lvlList.forEach(function(spr:FlxSprite) {
			spr.screenCenter();
		});
	}
}
