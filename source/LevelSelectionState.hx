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
	var lvlList:FlxTypedGroup<FlxSprite>;
	var lvlShit:Array<String> = [
		"demo"
	];
	
	override public function create()
	{
		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.screenCenter();
		add(bg);

		lvlList = new FlxTypedGroup<FlxSprite>();
		add(lvlList);

		for (i in 0...lvlShit.length)
		{
			var lvlThumbnails:FlxSprite = new FlxSprite().loadGraphic("assets/images/levels/level_" + lvlShit[i] + ".png");
			lvlThumbnails.setGraphicSize(Std.int(lvlThumbnails.width * 0.5));
			lvlThumbnails.antialiasing = true;
			lvlThumbnails.ID = i;
			lvlList.add(lvlThumbnails);
			lvlThumbnails.updateHitbox();
		}

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
