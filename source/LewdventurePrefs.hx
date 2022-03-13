package;

import flixel.FlxG;
import flixel.util.FlxSave;

using StringTools;

class LewdventurePrefs
{
	public static var spriteAntialiasing:Bool = true;
	public static var lowDetail:Bool = false;
	public static var allowTweening:Bool = true;

	public function savePrefs()
	{
		FlxG.save.data.spriteAntialiasing = spriteAntialiasing;
		FlxG.save.data.lowDetail = lowDetail;
		FlxG.save.data.allowTweening = allowTweening;

		FlxG.save.flush();
	}

	public function loadPrefs()
	{
		if (FlxG.save.data.spriteAntialiasing != null) {
			spriteAntialiasing = FlxG.save.data.spriteAntialiasing;
		}

		if (FlxG.save.data.lowDetail != null) {
			lowDetail = FlxG.save.data.lowDetail;
		}

		if (FlxG.save.data.allowTweening != null) {
			allowTweening = FlxG.save.data.allowTweening;
		}
	}
}
