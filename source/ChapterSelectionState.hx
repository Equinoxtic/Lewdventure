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

class ChapterSelectionState extends FlxState
{
	var vignette:FlxSprite;
	var blackShit:FlxSprite;
	var vignetteTwn:FlxTween;
	var blackShitTwn:FlxTween;
	var chapterList:FlxTypedGroup<FlxSprite>;
	var chapterShit:Array<String> = [
		"limbo"
	];
	var canSelect:Bool = false;

	override public function create()
	{
		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.GRAY);
		bg.screenCenter();
		add(bg);
		
		chapterList = new FlxTypedGroup<FlxSprite>();
		add(chapterList);

		for (i in 0...chapterShit.length)
		{
			var chapters:FlxSprite = new FlxSprite((i * 20), 0).loadGraphic("assets/images/chapters/chapter_" + chapterShit[i] + ".png");
			chapters.setGraphicSize(Std.int(chapters.width * 0.5));
			chapters.antialiasing = true;
			chapters.ID = i;
			chapterList.add(chapters);
			chapters.updateHitbox();
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
		chapterList.forEach(function(spr:FlxSprite) {
			spr.screenCenter();
		});
	}
}
