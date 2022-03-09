package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	var startFullscreen:Bool = false;

	public function new()
	{
		super();
		addChild(new FlxGame(1280, 720, LoadingState, 1, 60, 60, true));
	}
}
