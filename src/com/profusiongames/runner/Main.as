package com.profusiongames.runner
{
	import com.profusiongames.runner.states.Game;
	import flash.display.Sprite;
	import flash.events.Event;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author UG
	 */
	public class Main extends Sprite 
	{
		private var starling:Starling;
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			starling = new Starling(Game, stage);
			starling.start();
			starling.showStatsAt();
		}
		
	}
	
}