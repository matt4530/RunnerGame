package com.profusiongames.runner.tiles 
{
	import flash.geom.Rectangle;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	import starling.textures.RenderTexture;
	/**
	 * ...
	 * @author UG
	 */
	public class TileGroup extends Sprite
	{
		private var _quad:Quad;
		
		//private var _renderImage:Image;
		//private var _renderTexture:RenderTexture;
		
		
		//[Embed(source = "../../../../../lib/foreground/trees/1.png")]private var Tree:Class;
		//private var _tree:Image;
		public function TileGroup() 
		{
			//_tree = Image.fromBitmap(new Tree());
			//_tree.scaleX = _tree.scaleY = 0.2;
			//addChild(_tree);
		}
		
		
        public function getCollisionBounds(targetSpace:DisplayObject):Rectangle
        {
			var rect:Rectangle = /*_renderImage.*/getBounds(targetSpace);
			//trace(rect);
			rect.height = 2;
			return rect;
		}
		
		 public function getFallBounds(targetSpace:DisplayObject):Rectangle
        {
			var rect:Rectangle = /*_renderImage.*/getBounds(targetSpace);
			//trace(rect);
			rect.y += 5;
			rect.height -= 5;
			rect.width = 2;
			return rect;
		}
		
		public function getPlatformTop():int
		{
			return stage.stageHeight - _quad.height;
		}
		
		public function repositionAndDraw( platformWidth:int,platformHeight:int):void 
		{
			/*if (_renderTexture)
			{
				_renderTexture.dispose();
			}*/
			
			if (_quad)
			{
				_quad.height = platformHeight;
				_quad.width = platformWidth;
				
			}
			else
			{
				_quad = new Quad(platformWidth, platformHeight, 0);
				//_quad.setVertexColor(0, Math.random() * 0xFFFFFF);
				_quad.setVertexColor(0, 0x000000);
				//_quad.setVertexColor(1, Math.random() * 0xFFFFFF);
				_quad.setVertexColor(1, 0x000000);
				//_quad.setVertexColor(2, Math.random() * 0xFFFFFF);
				_quad.setVertexColor(2, 0x000000);
				_quad.setVertexColor(3, 0x000000);
				//_quad.filter = new BlurFilter();
				addChild(_quad);
			}
			
			
			/*_renderTexture = new RenderTexture(_quad.width, _quad.height);
			_renderTexture.draw(_quad);
			
			if (_renderImage)
				_renderImage.texture = _renderTexture;
			else
			{
				_renderImage = new Image(_renderTexture);
				addChild(_renderImage);
			}
			*/
			
			
			//_tree.y = -_tree.height;
			
			
			pivotY = /*_renderImage.*/height;
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