package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

using StringTools;

class LoadingState extends FlxState
{
	var werningTxt:FlxText;
	var loadCube:FlxSprite;
	var goingToState:Bool = false;

	override public function create() 
	{
		FlxG.autoPause = false;

		if (FlxG.mouse.visible) {
			FlxG.mouse.visible = false;
		} else {
			FlxG.mouse.visible = true;
		}

		werningTxt = new FlxText(0, 0, FlxG.width, "", 25);
		werningTxt.setFormat(AssetPaths.CascadiaCodePL_Regular__ttf, 25, FlxColor.WHITE, CENTER);
		werningTxt.text = "WARNING\n\n" + "This game contains sexual and mature content.\n" + "Play it in a dark room all alone, and without your parents around you.\n" + "Enjoy the game, cupcake~..";
		werningTxt.screenCenter();
		werningTxt.alpha = 0;
		add(werningTxt);

		loadCube = new FlxSprite().makeGraphic(50, 50, FlxColor.WHITE);
		loadCube.x = 150 * 7.8;
		loadCube.y = werningTxt.y + 325;
		add(loadCube);

		var secondLoadCube = new FlxSprite().makeGraphic(40, 40, FlxColor.BLACK);
		secondLoadCube.x = loadCube.x + 5;
		secondLoadCube.y = loadCube.y + 5;
		add(secondLoadCube);

		super.create();

		FlxG.camera.alpha = 0;
		FlxG.camera.zoom = 0.85;

		FlxTween.tween(FlxG.camera, {alpha: 1, zoom: 1}, 1.7, {ease: FlxEase.quartInOut});
		FlxTween.tween(loadCube, {angle: 360}, 1.7, {ease: FlxEase.cubeInOut, type: FlxTweenType.LOOPING, loopDelay: 0.3});
		FlxTween.tween(secondLoadCube, {angle: 360}, 1.7, {ease: FlxEase.cubeInOut, type: FlxTweenType.LOOPING, loopDelay: 0.3, startDelay: 0.05});
		FlxTween.tween(werningTxt, {alpha: 1}, 1.7, {ease: FlxEase.cubeInOut});

		new FlxTimer().start(11.5, function(tmr:FlxTimer) {
			goingToState = true;
			FlxTween.tween(FlxG.camera, {alpha: 0, zoom: 0.85}, 1.7, {ease: FlxEase.quartInOut});
		});
	}

	override public function update(elapsed:Float) 
	{
		if (goingToState) {
			new FlxTimer().start(1.7, function(tmr:FlxTimer) {
				FlxG.switchState(new TitleScreenState());
			});
		}
		super.update(elapsed);
	}
}
