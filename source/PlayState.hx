package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.system.FlxSound;

using StringTools;

class PlayState extends FlxState
{
	var moan:FlxSound;
	var player:FlxSprite;
	var vignette:FlxSprite;
	var died:Bool = false;
	public static var currentLevel:String = "";
	public static var ending:String = "";

	override public function create()
	{
		moan = FlxG.sound.load(AssetPaths.animoo_moan__ogg);

		player = new FlxSprite().makeGraphic(25, 25, FlxColor.WHITE);
		player.x = FlxG.width / 2 - player.width / 2;
		player.y = FlxG.height / 2 - player.height / 2;
		add(player);

		vignette = new FlxSprite().loadGraphic("assets/images/vignette.png");
		vignette.setGraphicSize(Std.int(vignette.width * 1.5));
		vignette.screenCenter();
		vignette.antialiasing = true;
		vignette.alpha = 0;
		add(vignette);

		super.create();
	}

	var sped:Int = 0;
	var zoomin:Bool = false;
	var slowin:Bool = false;

	override public function update(elapsed:Float)
	{
		var zoom_cooldown:Int = 20;
		var slow_cooldown:Int = 10;

		if (FlxG.keys.justPressed.M) {
			moan.play();
		}

		new FlxTimer().start(zoom_cooldown, function(tmr:FlxTimer) {
			if (FlxG.keys.justPressed.SPACE) {
				zoomin = true;
				new FlxTimer().start(15, function(tmr:FlxTimer) {
					zoomin = false;
				});
			}
		});

		new FlxTimer().start(slow_cooldown, function(tmr:FlxTimer) {
			if (FlxG.keys.justPressed.C) {
				slowin = true;
				new FlxTimer().start(7, function(tmr:FlxTimer) {
					slowin = false;
				});
			}
		});

		updateMovement();

		super.update(elapsed);
	}

	function updateMovement()
	{
		if (zoomin) { zoomShit(); }
		else if (slowin) { slowShit(); }
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

	function zoomShit() {
		sped = 15;
		FlxTween.tween(vignette, {alpha: 0.25}, 0.7, {ease: FlxEase.quartInOut});
		FlxTween.tween(FlxG.camera, {zoom : 0.65}, 0.7, {ease: FlxEase.quartInOut});
	}

	function slowShit() {
		sped = 1;
		FlxTween.tween(vignette, {alpha: 1}, 0.7, {ease: FlxEase.quartInOut});
		FlxTween.tween(FlxG.camera, {zoom : 1.35}, 0.7, {ease: FlxEase.quartInOut});
	}
}
