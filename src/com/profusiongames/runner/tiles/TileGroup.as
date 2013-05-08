package com.profusiongames.runner.tiles 
{
	import com.profusiongames.runner.entities.Player;
	import flash.geom.Rectangle;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.QuadBatch;
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
		private var _batch:QuadBatch;
		
		//private var _renderImage:Image;
		//private var _renderTexture:RenderTexture;
		
		private var _blood:Vector.<Quad> = new Vector.<Quad>();
		
		private var lastBigBlood:int = 0;
		
		
		//[Embed(source = "../../../../../lib/foreground/trees/1.png")]private var Tree:Class;
		//private var _tree:Image;
		public function TileGroup() 
		{
			//_tree = Image.fromBitmap(new Tree());
			//_tree.scaleX = _tree.scaleY = 0.2;
			//addChild(_tree);
			
			_batch = new QuadBatch();
			addChild(_batch);
			
			alpha = 0.4;
		}
		
		public function bleedOn(p:Player):void
		{
			//return;
			
			if (p.x < x)
				return;
			if (p.x > x + width)
				return;
				
			if (p.ySpeed > 0)
				lastBigBlood = 0;
			
			
			var original:uint = 0xCD0000;
			var ru:Number = 0xCD;
			var gu:Number = 0x00;
			var bu:Number = 0x00;
			var value:Number = ( ru + gu + bu)/3;
			var newValue:Number = value + Math.random() * 10 - 5;
			var ratio:Number = newValue / value;
			var c:uint = ((ru * ratio) << 16) | ((gu * ratio) << 8) | (bu * ratio);	
			
			
			
		
			var b:Quad = new Quad(p.ySpeed > 0 ? Math.max(p.xSpeed, p.ySpeed * 3) : p.xSpeed, p.ySpeed > 0 ? p.ySpeed * 4 : Math.max(150/lastBigBlood, 4), c);
			b.x = p.x - x;
			b.y = 0//-_quad.height;
			_batch.addQuad(b);
			_blood.push(b);
			
			
			
			lastBigBlood++;
			//trace("getting bled on", b.x, b.y, x, y);
			
		}
		
		
        public function getCollisionBounds(targetSpace:DisplayObject):Rectangle
        {
			var rect:Rectangle = new Rectangle(x, y - _quad.height, _quad.width, 2);///*_renderImage.*/_quad.getBounds(targetSpace);
			//trace(rect, getBounds(targetSpace));
			//rect.height = 2;
			return rect;
		}
		
		 public function getFallBounds(targetSpace:DisplayObject):Rectangle
        {
			var rect:Rectangle = new Rectangle(x, y - _quad.height + 5, 2, _quad.height - 5);///*_renderImage.*/_quad.getBounds(targetSpace);
			//trace(rect);
			//rect.y += 5;
			//rect.height -= 5;
			//rect.width = 2;
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
			var original:uint = 0x7A8B8B;
			var r:Number = 0x7A;
			var g:Number = 0x8B;
			var b:Number = 0x8B;
			var value:Number = ( r + g + b)/3;
			var newValue:Number = value + Math.random() * 120 - 60;
			var ratio:Number = newValue / value;
			var c:uint = ((r * ratio) << 16) | ((g * ratio) << 8) | (b * ratio);
			
			
			if (_quad)
			{
				_quad.height = platformHeight;
				_quad.width = platformWidth;
				
				_quad.setVertexColor(0, c);
				_quad.setVertexColor(1, c);
				_quad.setVertexColor(2, c);
				_quad.setVertexColor(3, c);
				
			}
			else
			{
				_quad = new Quad(platformWidth, platformHeight, c);
				//////////////_quad.setVertexColor(0, Math.random() * 0xFFFFFF);
				////////////_quad.setVertexColor(0, 0x000000);
				//////////////_quad.setVertexColor(1, Math.random() * 0xFFFFFF);
				////////////_quad.setVertexColor(1, 0x000000);
				//////////////_quad.setVertexColor(2, Math.random() * 0xFFFFFF);
				////////////_quad.setVertexColor(2, 0x000000);
				////////////_quad.setVertexColor(3, 0x000000);
				//_quad.filter = new BlurFilter();
				//addChild(_quad);
			}
			
			
			if (_batch)
			{
				_batch.reset();
				_batch.addQuad(_quad);
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