package com.profusiongames.runner.tiles 
{
	import flash.geom.Rectangle;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	/**
	 * ...
	 * @author UG
	 */
	public class TileGroup extends Sprite
	{
		private var _quad:Quad;
		public function TileGroup() 
		{
			
		}
		
		
        public function getCollisionBounds(targetSpace:DisplayObject):Rectangle
        {
			var rect:Rectangle = getBounds(targetSpace);
			//trace(rect);
			rect.height = 2;
			return rect;
		}
		
		 public function getFallBounds(targetSpace:DisplayObject):Rectangle
        {
			var rect:Rectangle = getBounds(targetSpace);
			//trace(rect);
			rect.y += 5;
			rect.height -= 5;
			rect.width = 2;
			return rect;
		}
		
		public function repositionAndDraw( platformWidth:int,platformHeight:int):void 
		{
			if (_quad)
			{
				_quad.height = platformHeight;
				_quad.width = platformWidth;
			}
			else
			{
				_quad = new Quad(platformWidth, platformHeight, 0);
				_quad.setVertexColor(0, Math.random() * 0xFFFFFF);
				_quad.setVertexColor(1, Math.random() * 0xFFFFFF);
				_quad.setVertexColor(2, Math.random() * 0xFFFFFF);
				addChild(_quad);
			}
			pivotY = height;
			y = stage.stageHeight;
		}
		
		private function init(tilesWide:int, tilesTall:int):void 
		{
			_quad = new Quad(tilesWide * 100, tilesTall * 100, 0);
			
			addChild(_quad);
			/*for (var i:int = 0; i < tilesWide; i++)
			{
				_tiles[i] = new Vector.<Tile>();
				for (var j:int = 0; j < tilesTall; j++)
				{
					var t:Tile = new Tile();
					var tEdge:String = "";
					if ( i == 0)
						tEdge = "left";
					if (i == tilesWide -1)
						tEdge = "right";
					if (j == 0)
						tEdge += "up";
						
					if (tEdge == "")
						tEdge = "none";
					
					t.edge = tEdge;
					t.type = "building";
					t.x = i * t.width;
					t.y = j * t.height;
					addChild(t);
					
				}
			}*/
		}
		
	}

}