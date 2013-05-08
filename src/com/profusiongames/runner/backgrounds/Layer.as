package com.profusiongames.runner.backgrounds
{
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Layer extends Sprite
	{
		[Embed(source="../../../../../lib/background/cloud.png")]
		private static var cloudAsset:Class
		[Embed(source="../../../../../lib/background/land.png")]
		private static var landAsset:Class
		
		private var _image1:DisplayObject;
		private var _image2:DisplayObject;
		
		private var _layer:int;
		private var _parallax:Number;
		
		public function Layer(layer:int)
		{
			super();
			_layer = layer;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			if (_layer == 1)
			{
				/*var q:Quad = new Quad(800, 600);
				   var bottomColor:uint = 0x00FF00;
				   var topColor:uint = 0xFFFF00;
				   q.setVertexColor(0, topColor);
				   q.setVertexColor(1, topColor);
				   q.setVertexColor(2, bottomColor);
				   q.setVertexColor(3, bottomColor);
				 _image1 = q;*/
				_image1 = new PerlinLayer();
				
					//_image2 = new PerlinLayer();
			}
			else if (_layer == 2)
			{
				_image1 = Image.fromBitmap(new cloudAsset());
				_image2 = Image.fromBitmap(new cloudAsset());
				_image1.scaleX = 4;
				_image1.scaleY = 4;
				_image2.scaleX = 4;
				_image2.scaleY = 4;
				_image1.x = 0;
				_image1.y = stage.stageHeight - _image1.height;
			}
			else if (_layer == 3)
			{
				_image1 = Image.fromBitmap(new cloudAsset());
				_image2 = Image.fromBitmap(new cloudAsset());
				_image1.scaleX = 4;
				_image1.scaleY = 4;
				_image2.scaleX = 4;
				_image2.scaleY = 4;
				
				_image1.x = 0;
				_image1.y = stage.stageHeight - _image1.height;
			}
			else if (_layer == 4)
			{
				_image1 = Image.fromBitmap(new landAsset());
				_image2 = Image.fromBitmap(new landAsset());
				_image1.scaleX = 4;
				_image1.scaleY = 4;
				_image2.scaleX = 4;
				_image2.scaleY = 4;
				_image1.x = 0;
				_image1.y = stage.stageHeight - _image1.height;
			}
			
			addChild(_image1);
			
			if (_image2)
			{
				_image2.x = _image2.width;
				_image2.y = _image1.y;
				addChild(_image2);
			}
		}
		
		public function get layerWidth():Number
		{
			return _image1.width
		}
		
		public function get parallax():Number
		{
			return _parallax;
		}
		
		public function set parallax(value:Number):void
		{
			_parallax = value;
		}
	
	}

}