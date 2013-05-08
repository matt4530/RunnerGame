package com.profusiongames.runner.states 
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author UG
	 */
	public class StartGame extends Sprite 
	{
		private var _present:TextField;
		private var _gameName:TextField;
		private var _instructions:TextField;
		public function StartGame() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_present = new TextField(stage.stageWidth, 50, "Philip Hahs and Matt Pope present", "Verdana", 12, 0xFFFFFF, false);
			_present.y = 30;
			_present.hAlign = "center";
			addChild(_present);
			
			_gameName = new TextField(stage.stageWidth, 300, "Ice Runner", "Verdana", 120, 0xFFFFFF, true);
			_gameName.y = stage.stageHeight/2 - _gameName.height;
			_gameName.vAlign = "bottom";
			_gameName.hAlign = "center";
			addChild(_gameName);
			
			_instructions = new TextField(stage.stageWidth, 50, "Press X or C to start your adventure", "Verdana", 12, 0xFFFFFF, false);
			_instructions.y = stage.stageHeight - _instructions.height;
			addChild(_instructions);
			
		}
		
	}

}