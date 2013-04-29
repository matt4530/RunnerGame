package com.profusiongames.runner.items 
{
	import com.greensock.TweenLite;
	import starling.display.BlendMode;
	import starling.display.Quad;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Orb extends Quad
	{
		
		public function Orb() 
		{
			super(20, 20, 0xFFFFFF);
			pivotX = 10;
			pivotY = 10;
			blendMode = BlendMode.ADD;
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, kill);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(EnterFrameEvent.ENTER_FRAME, frame);
		}
		
		private function frame(e:EnterFrameEvent):void 
		{
			rotation += 0.2;
			
		}
		
		private function kill(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, kill);
			stage.removeEventListener(EnterFrameEvent.ENTER_FRAME, frame);
		}
		
	}

}