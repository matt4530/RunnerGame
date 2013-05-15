package com.profusiongames.runner.ui 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author UG
	 */
	public class Hud extends Quad
	{
		private static var _i:Hud;
		private static var _health:Number = 100;
		public function Hud() 
		{
			super(800, 10, 0xFF0000);
			
			
		}
		
		static public function get i():Hud 
		{
			if (_i == null)
				_i = new Hud();
			return _i;
		}
		
		static public function set i(value:Hud):void 
		{
			_i = value;
		}
		
		static public function get health():Number 
		{
			return _health;
		}
		
		static public function set health(value:Number):void 
		{
			_health = value;
			i.width = i.stage != null ? i.stage.stageWidth * value : 800;

			
			//i.setTexCoords(0, new Point(0,value));
			//i.setTexCoords(1, new Point(0,value));
			
		}
		
		
		
		
	}

}