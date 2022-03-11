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
import flixel.addons.effects.FlxTrail;

using StringTools;

class PlayState extends FlxState
{
	var moan:FlxSound;
	var player:FlxSprite;
	var died:Bool = false;
	var currentLevel:String = "";
	var npc:FlxSprite;
	var npcversion:String = "";
	public static var ending:String;

	override public function create()
	{
		moan = FlxG.sound.load(AssetPaths.animoo_moan__ogg);

		player = new FlxSprite().makeGraphic(15, 15, FlxColor.BLUE);
		player.x = FlxG.width / 2 - player.width / 2;
		player.y = FlxG.height / 2 - player.height / 2;
		add(player);

		super.create();
	}

	var sped:Int = 0;
	var zoomin:Bool = false;

	override public function update(elapsed:Float)
	{
		var cooldown:Int = 1;

		if (FlxG.keys.justPressed.M) {
			moan.play();
		}

		new FlxTimer().start(cooldown, function(tmr:FlxTimer) {
			if (FlxG.keys.justPressed.SPACE) {
				zoomin = true;
				new FlxTimer().start(0.7, function(tmr:FlxTimer) {
					zoomin = false;
				});
			}
		});

		updateMovement();

		super.update(elapsed);
	}

	function updateMovement()
	{
		if (zoomin) { sped = 15; }
		else { sped = 5; }

		var _up:Bool = FlxG.keys.anyPressed([UP, W]);
		var _down:Bool = FlxG.keys.anyPressed([DOWN, S]);
		var _left:Bool = FlxG.keys.anyPressed([LEFT, A]);
		var _right:Bool = FlxG.keys.anyPressed([RIGHT, D]);
		if (_up) player.y -= sped;
		if (_down) player.y += sped;
		if (_left) player.x -= sped;
		if (_right) player.x += sped;
	}
}
