package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.system.FlxSound;

using StringTools;

class PlayState extends FlxState
{
	var moan:FlxSound;
	public static var ending:String;

	override public function create()
	{
		moan = FlxG.sound.load(AssetPaths.animoo_moan__ogg);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.M) {
			moan.play();
		}

		super.update(elapsed);
	}
}
