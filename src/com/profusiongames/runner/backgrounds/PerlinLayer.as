package com.profusiongames.runner.backgrounds 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.setInterval;
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class PerlinLayer extends Layer 
	{
		private var _renderTexture:RenderTexture;
		private var _layer:Sprite;
		private var _gradient:Image;
		private var _gradientSprite:flash.display.Sprite
		private var _gradientBitmap:Bitmap;
		private var perlinBitmap:Bitmap;
		
		
		public function PerlinLayer(layer:int) 
		{
			super(layer);
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			
			generatePerlinNoise();
			generateColorMap();
			
			//mapPerlinToColors();
			
			var q:Quad = new Quad(800, 600);
			q.setVertexColor(0, 0x00FF00);
			q.setVertexColor(1, 0xFFFF00);
			q.setVertexColor(2, 0x00FF00);
			q.setVertexColor(3, 0xFFFF00);
			addChild(q);
			
			
			
			//addChild(_gradient);
			addChild(_layer);
			_layer.blendMode = BlendMode.ADD
		}
		
		
		private function generatePerlinNoise():void 
		{
			perlinBitmap = new Bitmap(new BitmapData(800, 600, true, 0x00FFFFFF));
			var perlinBitmapData:BitmapData = perlinBitmap.bitmapData;
			
			perlinBitmapData.perlinNoise(150, 150, 1, 0, false, true, 1, true);
			_renderTexture = new RenderTexture(800, 600,true,0.2);
			_renderTexture.draw(new Image(Texture.fromBitmap(perlinBitmap)));
			
			var perlinImage:Image = new Image(_renderTexture);
			
			_layer = new Sprite();
			_layer.addChild(perlinImage);
		}
		
		private function generateColorMap():void 
		{
			_gradientSprite = new flash.display.Sprite();
			var fType:String = GradientType.LINEAR;
			//Colors of our gradient in the form of an array
			var colors:Array = [ 0x00FF00, 0xFFFF00 ];
			//Store the Alpha Values in the form of an array
			var alphas:Array = [ 1, 1 ];
			//Array of color distribution ratios.  
			//The value defines percentage of the width where the color is sampled at 100%
			var ratios:Array = [ 0, 255 ];
			//Create a Matrix instance and assign the Gradient Box
			var matr:Matrix = new Matrix();
				matr.createGradientBox( 800, 600, 0, 0, 0 );
			//SpreadMethod will define how the gradient is spread. Note!!! Flash uses CONSTANTS to represent String literals
			var sprMethod:String = SpreadMethod.PAD;
			//Save typing + increase performance through local reference to a Graphics object
			var g:Graphics = _gradientSprite.graphics;
				g.beginGradientFill( fType, colors, alphas, ratios, matr, sprMethod );
				g.drawRect( 0, 0, 800, 600 );
			
			_gradientBitmap = new Bitmap(new BitmapData(800, 600, true, 0x00FFFFFF));
			_gradientBitmap.bitmapData.draw(_gradientSprite);
			_gradient = Image.fromBitmap(_gradientBitmap);
		}
		
		private function mapPerlinToColors():void 
		{
			var v:Vector.<uint> = perlinBitmap.bitmapData.getVector(new Rectangle(0, 0, perlinBitmap.width, perlinBitmap.height));
			
			var startColor:uint = 0x00FF00;
			var endColor:uint = 0xFFFF00;
			
			var sa:uint = 0xFF;
			var sr:uint = 0x00;
			var sg:uint = 0xFF;
			var sb:uint = 0x00;
			
			var ea:uint = 0xFF
			var er:uint = 0xFF
			var eg:uint = 0xFF
			var eb:uint = 0x00
			
			trace(v[0], 0xFFFFFF, 0xFFFFFFFF, v[0]/0xFFFFFFFF, v.length);
			for (var i:int = 0; i < v.length; i++)
			{
				
				var s:Number = v[i] / 0xFFFFFFFF;
				var t:Number = 1 - s;
				//v[i] = alpha				red					green				blue
				v[i] = 0xFF << 24 | int(sr * t + er * s) << 16 | int(sg * t + eg * s) << 8 | 		int(sb * t + eb * s);
				trace(v[i]);
			}
			
			perlinBitmap.bitmapData.setVector(new Rectangle(0, 0, perlinBitmap.width, perlinBitmap.height), v);
		}
		
	}

}