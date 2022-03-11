package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;

using StringTools;

class ChapterSelectionState extends FlxState
{
	var vignette:FlxSprite;
	var blackShit:FlxSprite;
	var chapterList:FlxTypedGroup<FlxSprite>;
	var chapterShit:Array<String> = [
		"limbo"
	];

	override public function create()
	{
		chapterList = new FlxTypedGroup<FlxSprite>();
		add(chapterList);

		for (i in 0...chapterShit.length)
		{
			var chapters:FlxSprite = new FlxSprite(0, (i * 20)).loadGraphic("assets/chapters/chapter_" + chapterShit[i] + ".png");
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
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
