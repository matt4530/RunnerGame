package com.profusiongames.runner.states 
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author UG
	 */
	public class EndGame extends Sprite 
	{
		private var _gameOverText:TextField;
		private var _restartText:TextField;
		private var _distanceText:TextField;
		public var distance:Number = 0;
		public function EndGame() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_gameOverText = new TextField(stage.stageWidth, 100, "Game Over", "Verdana", 72, 0xFFFFFF);
			addChild(_gameOverText);
			_gameOverText.y = stage.stageHeight / 2 - _gameOverText.height / 2;
			
			_restartText = new TextField(stage.stageWidth, 50, "Press X or C to restart", "Verdana", 12, 0xFFFFFF);
			addChild(_restartText);
			_restartText.y = stage.stageHeight - _restartText.height;
			_restartText.hAlign = "center";
			_restartText.vAlign = "bottom";
			
			_distanceText = new TextField(stage.stageWidth, 100, distance + " pixels.", "Verdana", 48, 0xFFFFFF);
			addChild(_distanceText);
			_distanceText.y = _gameOverText.y + 65;
		}
		
	}

}