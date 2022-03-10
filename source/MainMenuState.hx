package;

import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.system.FlxSound;

using StringTools;

class MainMenuState extends FlxState
{
	var bg:FlxSprite;
	var sidebar:FlxSprite;
	var invis:FlxSprite;
	var blackshit:FlxSprite;
	var vignette:FlxSprite;
	var blackshittwn:FlxTween;
	var vignettetwn:FlxTween;
	var canSelect:Bool = false;
	// var camAlphaTwn:FlxTween;
	var clickSound:FlxSound;
	var icons:FlxSprite;

	var menuIcons:FlxTypedGroup<FlxSprite>;
	var iconShit:Array<String> = [
		"home",
		"settings",
		"achievements",
		"notification",
		"github",
		"sound-test"
	];

	var daTxt:FlxText;

	override public function create()
	{
		if (!FlxG.mouse.visible) {
			FlxG.mouse.visible = true;
		}

		clickSound = FlxG.sound.load(AssetPaths.enter_sound__ogg);

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.GRAY);
		bg.screenCenter();
		add(bg);

		sidebar = new FlxSprite().makeGraphic(75, FlxG.height, FlxColor.BLACK);
		sidebar.x = 245 * 5;
		add(sidebar);

		menuIcons = new FlxTypedGroup<FlxSprite>();
		add(menuIcons);

		for (i in 0...iconShit.length)
		{
			icons = new FlxSprite(sidebar.x - 22, (i * 55)).loadGraphic("assets/images/icons/icon_" + iconShit[i] + ".png");
			icons.setGraphicSize(Std.int(icons.width * 0.45));
			icons.antialiasing = true;
			icons.ID = i;
			menuIcons.add(icons);
		}

		vignette = new FlxSprite().loadGraphic("assets/images/vignette.png");
		vignette.setGraphicSize(Std.int(vignette.width * 1.5));
		vignette.screenCenter();
		vignette.antialiasing = true;
		add(vignette);

		blackshit = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackshit.screenCenter();
		add(blackshit);

		super.create();

		/* Old shit :troll:
		FlxG.camera.alpha = 0;
		camAlphaTwn = FlxTween.tween(FlxG.camera, {alpha: 1}, 3.5, {onComplete: function(twn:FlxTween) {
			canSelect = true;
		}});
		*/

	 	blackshittwn = FlxTween.tween(blackshit, {alpha: 0.45}, 2.85, {ease: FlxEase.quartInOut});
		vignettetwn = FlxTween.tween(vignette, {alpha: 0.45}, 2.35, {ease: FlxEase.quartInOut});
		new FlxTimer().start(blackshittwn.duration, function(tmr:FlxTimer) {
			canSelect = true;
		});
	}

	var selected:Bool = false;

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.BACKSPACE) {
			returnToTitle();
		}
		super.update(elapsed);
	}

	function returnToTitle()
	{
		clickSound.play();
		FlxTween.tween(blackshit, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});
		FlxTween.tween(vignette, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});
		new FlxTimer().start(1.1, function(tmr:FlxTimer) {
			FlxG.switchState(new TitleScreenState());
		});
	}
}
