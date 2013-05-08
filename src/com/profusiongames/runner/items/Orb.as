package com.profusiongames.runner.items 
{
	import com.greensock.TweenLite;
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Orb extends Image
	{
		[Embed(source = "../../../../../lib/foreground/drops/potion.png")]private static var Potion:Class;
		private static var staticTexture:Texture;
		public function Orb() 
		{
			if (staticTexture == null)
				staticTexture = Texture.fromBitmap(new Potion());
			super(staticTexture);
			pivotX = staticTexture.width/2;
			pivotY =0;
			
			scaleX = scaleY = 2;
			smoothing = TextureSmoothing.NONE;
			
			//blendMode = BlendMode.ADD;
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
			//rotation += 0.02;
			
		}
		
		private function kill(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, kill);
			stage.removeEventListener(EnterFrameEvent.ENTER_FRAME, frame);
		}
		
	}

}