package com.profusiongames.runner.tiles 
{
	import starling.display.Image;
	import starling.display.Quad;
	
	/**
	 * ...
	 * @author UG
	 */
	public class Tile extends Quad 
	{
		private var _type:String;
		private var _edge:String;
		public function Tile() 
		{
			super(100, 100);
			pivotX = 50;
			pivotY = 50;
		}
		
		public function get type():String { return _type; }
		public function set type(value:String):void 
		{
			_type = value;
			setVertexColor(0, 0x000000);
			setVertexColor(1, 0x000000);
			setVertexColor(2, 0x000000);
			setVertexColor(3, 0x000000);
			/*switch(value)
			{
				case "grass":
					setVertexColor(0, 0x00FF00);
					setVertexColor(1, 0x00FF00);
					setVertexColor(2, 0xFFFF66);
					setVertexColor(3, 0xFFFF66);
					break;
				case "grass left edge":
					setVertexColor(0, 0x00FF00);
					setVertexColor(2, 0x00FF00);
					setVertexColor(1, 0xFFFF66);
					setVertexColor(3, 0xFFFF66);
					break;
				case "grass right edge":
					setVertexColor(1, 0x00FF00);
					setVertexColor(3, 0x00FF00);
					setVertexColor(0, 0xFFFF66);
					setVertexColor(2, 0xFFFF66);
					break;
			}*/
		}
		
		public function get edge():String {return _edge;}
		public function set edge(value:String):void 
		{
			_edge = value;
			switch(value)
			{
				case "left":
					rotation = 3 * Math.PI / 2;
					break;
				case "leftup":
					rotation = 3 * Math.PI / 2;
					break;
				case "up":
					rotation = 0;
					break;
				case "rightup":
					rotation = Math.PI / 2;
					break;
				case "right":
					rotation = Math.PI / 2;
					break;
				case "none":
				
			}
		}
		
		
		
		
	}

}