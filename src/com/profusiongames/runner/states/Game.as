package com.profusiongames.runner.states 
{
	import com.profusiongames.runner.backgrounds.Background;
	import com.profusiongames.runner.entities.Player;
	import com.profusiongames.runner.filters.VignetteFilter;
	import com.profusiongames.runner.tiles.Tile;
	import com.profusiongames.runner.tiles.TileGroup;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author UG
	 */
	public class Game extends Sprite 
	{
		private var _background:Background;
		private var _groups:Vector.<TileGroup> = new Vector.<TileGroup>();
		private var _pool:Vector.<TileGroup> = new Vector.<TileGroup>();
		private var _player:Player = new Player();
		
		private var _vignette:VignetteFilter;
		
		private var speed:Number = 10;
		private var nextPosition:int = 0;
		private var endGame:EndGame;
		
		private var _groupLayer:Sprite;
		
		
		[Embed(source="../../../../../lib/particles/snow/particle.pex", mimeType="application/octet-stream")]
		private static const SnowConfig:Class;
		 
		// embed particle texture
		[Embed(source="../../../../../lib/particles/snow/texture.png")]
		private static const SnowParticle:Class;
		private var _snowParticleSystem:PDParticleSystem;
		
		
		
		public function Game() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			trace("Added to stage");
			
			_background = new Background();
			_background.speed = speed;
			addChild(_background);
			
			
			
			_groupLayer = new Sprite();
			addChild(_groupLayer);
			
			
			//_background.blendMode = BlendMode.NONE;
			addChild(_player);
			//_player.blendMode = BlendMode.ADD;
			//filter = _vignette = new VignetteFilter(stage.stageWidth / 2, stage.stageHeight / 2, 1, 2.02, .64)//.98, .60)
			
			
			
			// instantiate embedded objects
			var psConfig:XML = XML(new SnowConfig());
			var psTexture:Texture = Texture.fromBitmap(new SnowParticle());
			 
			// create particle system
			_snowParticleSystem = new PDParticleSystem(psConfig, psTexture);
			_groupLayer.addChild(_snowParticleSystem);
			_groupLayer.setChildIndex(_snowParticleSystem, 1);
			Starling.juggler.add(_snowParticleSystem);
			
			_snowParticleSystem.start();
			
			
			
			
			
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, kDown);
			newGame();
		}
		
		private function kDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == 38)//up
				_vignette.radius += 0.01;
			if (e.keyCode == 40)
				_vignette.radius -= 0.01;
			if (e.keyCode == 87)
				_vignette.size += 0.01;
			if(e.keyCode == 83)
				_vignette.size -= 0.01;
			
			if(_vignette)
				trace(_vignette.radius, _vignette.size);
		}
		
		private function newGame():void
		{
			//remove existing groups, place in pool
			for (var i:int = 0; i < _groups.length; i++)
			{
				_pool.push(_groups[i]);
				_groupLayer.removeChild(_groups[i]);
			}
			_groups.length = 0;
			
			//generate starting platform from the pool or make a new one
			var tGroup:TileGroup;
			if (_pool.length == 0)
			{
				tGroup = new TileGroup();
			}
			else
			{
				tGroup = _pool[0];
				_pool.splice(0, 1);
			}
			_groupLayer.addChild(tGroup);
			tGroup.repositionAndDraw(90000,stage.stageHeight/2);
			tGroup.x = 50;
			_groups.push(tGroup);
			

			nextPosition = 100 + Math.random() * 150;
			
			_player.x = stage.stageWidth / 3;
			_player.y = stage.stageHeight / 3;
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, frame);
		}
		
		private function frame(e:EnterFrameEvent):void 
		{
			var i:int = 0
			
			
			/*
			 * Move platforms
			 */
			var lastPosition:int = 0;
			var playerCollideWith:TileGroup = null;
			var g:TileGroup;
			for (i=0; i < _groups.length; i++)
			{
				g = _groups[i];
				g.x = Math.ceil(g.x - speed);
				lastPosition = g.x + g.width;
				if (g.x < -g.width)
				{
					removeChild(g);
					_pool.push(g);
					_groups.splice(i, 1);
					i--;
				}
				else
				{	
					//var cachedRect:Rectangle = _player.getBounds(this);
					var cachedRect:Rectangle = _player.getBounds(this);
					cachedRect.x += speed;
					cachedRect.y += _player.ySpeed;
					if (playerCollideWith == null && g.getCollisionBounds(this).intersects(cachedRect)) //collision
					{
						playerCollideWith = g;
						g.getCollisionBounds(this);
					}
					else if (playerCollideWith == null && g.getFallBounds(this).intersects(cachedRect))
					{
						_player.x = g.x - _player.width / 2;
					}
				}
			}
			
			
			/*
			 * Spawn new platform
			 */
			if (stage.stageWidth - lastPosition > nextPosition)
			{
				if (_pool.length > 0)
				{
					g = _pool[_pool.length - 1];
					_pool.length--;
				}
				else
				{
					g = new TileGroup();
				}
				g.x = stage.stageWidth;
				_groupLayer.addChild(g);
				g.repositionAndDraw(Math.random() * 200 + 600, Math.random() * 150 + 200);
				
				
				_groups.push(g);
				
				nextPosition = 200 + Math.random() * 150;
			}
			
			
			
			
			//player update
			_player.frame(playerCollideWith);
			
			_background.frame(e, _player);
			//_background.y = Math.min(0, stage.stageHeight - _player.y);
			
			if (_player.y - _player.height > stage.stageHeight)
			{
				//end game
				removeEventListener(EnterFrameEvent.ENTER_FRAME, frame);
				
				endGame = new EndGame();
				stage.addChild(endGame);
				
				stage.addEventListener(KeyboardEvent.KEY_DOWN, onRestartWait);
			}
		}
		
		private function onRestartWait(e:KeyboardEvent):void 
		{
			if (e.keyCode == 88 || e.keyCode == 67 || e.keyCode == 32)
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onRestartWait);
				stage.removeChild(endGame);
				
				newGame();
			}
		}
		
	}

}