package com.profusiongames.runner.backgrounds 
{
	import com.profusiongames.runner.entities.Player;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.textures.TextureSmoothing;
	
	/**
	 * ...
	 * @author UG
	 */
	public class Background extends Sprite
	{
		[Embed(source = "../../../../../lib/background/cloud.png")]private var cloudAsset:Class
		[Embed(source = "../../../../../lib/background/land.png")]private var landAsset:Class
		
		
		private var layer1:Layer;
		private var layer2:Layer;
		private var layer3:Layer;
		private var layer4:Layer;
		
		private var _speed:Number = 0;
		
		public function Background() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			layer1 = new PerlinLayer(1);
			//layer1.parallax = 0;
			addChild(layer1);
			
			layer2 = new Layer(2);
			layer2.parallax = 0.2;
			addChild(layer2);
			
			layer3 = new Layer(3);
			layer3.parallax = 0.5;
			addChild(layer3);
			
			layer4 = new Layer(4);
			layer4.parallax = 1;
			addChild(layer4);
			
		}
		
		public function frame(e:EnterFrameEvent, player:Player):void 
		{
			//trace(layer1.parallax, _speed * layer1.parallax, Math.ceil(_speed * layer1.parallax));
			
			/*layer1.x -= Math.ceil(_speed * layer1.parallax);
			if (layer1.x < -layer1.layerWidth)
				layer1.x += layer1.layerWidth;
			*/
				
			layer2.x -= Math.ceil(_speed * layer2.parallax);
			if (layer2.x < -layer2.layerWidth)
				layer2.x += layer2.layerWidth;
			layer2.y = Math.max(0, layer2.parallax * (stage.stageHeight - player.y));
				
			layer3.x -= Math.ceil(_speed * layer3.parallax);
			if (layer3.x < -layer3.layerWidth)
				layer3.x += layer3.layerWidth;
			layer3.y = Math.max(0, layer3.parallax * (stage.stageHeight - player.y));
				
			layer4.x -= Math.ceil(_speed * layer4.parallax);
			if (layer4.x < -layer4.layerWidth)
				layer4.x += layer4.layerWidth;
				
			layer4.y = Math.max(0, layer4.parallax * (stage.stageHeight - player.y));
		}
		
		/*private function init(w:int, h:int):void 
		{
			_gradient = new Quad(w, h);
			addChild(_gradient);
			
			var bottomColor:uint = 0x00FF00;
			//var bottomColor:uint = 0x1E095E;
			//var topColor:uint = 0x000000;
			var topColor:uint = 0xFFFF00;
			
			_gradient.setVertexColor(0, topColor);
			_gradient.setVertexColor(1, topColor);
			_gradient.setVertexColor(2, bottomColor);
			_gradient.setVertexColor(3, bottomColor);
			
			_cloud = Image.fromBitmap(new cloudAsset());
			_cloud.smoothing = TextureSmoothing.NONE;
			_cloud.pivotY = _cloud.height;
			addChild(_cloud);
			
			_cloud.scaleX = _cloud.scaleY = 4;
			_cloud.y = h;
			
			
			
			_land = Image.fromBitmap(new cloudAsset());// new landAsset());
			_land.smoothing = TextureSmoothing.NONE;
			_land.alpha = 1;
			_land.pivotY = _land.height;
			addChild(_land);
			
			_land.scaleX = _land.scaleY = 3;
			_land.y = h;
		}*/
		
		public function get speed():Number { return _speed; }
		public function set speed(value:Number):void { _speed = value; }
		
	}

}