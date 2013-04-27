package com.profusiongames.runner.entities 
{
	import com.greensock.TweenLite;
	import com.profusiongames.runner.tiles.TileGroup;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Player extends Sprite
	{
		private var _quad:Quad;
		
		
		private var _ySpeed:Number = 0;
		private var _gravity:Number = 0.7;
		private var _jumpPower:Number = 6
		
		private var _hasLandedSinceJump:Boolean = false;
		private var _lastJumpTimestamp:int = 0
		private var _currentlyJumpIsDown:Boolean = false;
		private var _frameCountFromJump:int = 0;
		private var _canDoubleJump:Boolean = false;
		private var _isDoubleJumping:Boolean = false;
		private var _upReleasedInAir:Boolean = false;
		private var _boosterTime:int = 120;
		
		
		[Embed(source="../../../../../lib/particles/burst/particle.pex", mimeType="application/octet-stream")]
		private static const BurstConfig:Class;
		 
		// embed particle texture
		[Embed(source="../../../../../lib/particles/burst/texture.png")]
		private static const BurstParticle:Class;
		private var _burstParticleSystem:PDParticleSystem;
		
		
		[Embed(source = "../../../../../lib/particles/booster/particle.pex", mimeType = "application/octet-stream")]
		private static const BoosterConfig:Class;
		[Embed(source = "../../../../../lib/particles/booster/texture.png")]
		private static const BoosterParticle:Class;
		private var _boosterParticleSystem:PDParticleSystem;
		
		public function Player() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_quad = new Quad(50, 50);
			_quad.setVertexColor(0, 0xFFFFFF);
			_quad.setVertexColor(1, 0xFFFFFF);
			_quad.setVertexColor(2, 0xFFFFFF);
			_quad.setVertexColor(3, 0xFFFFFF);
			addChild(_quad);
			
			pivotX = _quad.width / 2;
			pivotY = _quad.height;
			
			//blendMode = BlendMode.ADD;
			
			
			
			// instantiate embedded objects
			var psConfig:XML = XML(new BurstConfig());
			var psTexture:Texture = Texture.fromBitmap(new BurstParticle());
			 
			// create particle system
			_burstParticleSystem = new PDParticleSystem(psConfig, psTexture);
			parent.addChild(_burstParticleSystem);
			parent.setChildIndex(_burstParticleSystem, 1);
			Starling.juggler.add(_burstParticleSystem);
			//_burstParticleSystem.blendMode = BlendMode.ADD;
			//_burstParticleSystem.start();
			
			
			var psBoostConfig:XML = XML(new BoosterConfig());
			var psBoostTexture:Texture = Texture.fromBitmap(new BoosterParticle());
			
			_boosterParticleSystem = new PDParticleSystem(psBoostConfig, psBoostTexture);
			//_boosterParticleSystem.emitterX = stage.stageWidth / 2;
			//_boosterParticleSystem.emitterY = stage.stageHeight / 2;
			_boosterParticleSystem.emitterY = height/2
			addChild(_boosterParticleSystem);
			Starling.juggler.add(_boosterParticleSystem);
			//_boosterParticleSystem.start();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, kDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, kUp);
		}
		
		private function kUp(e:KeyboardEvent):void 
		{
			_currentlyJumpIsDown = false;
			if (_isDoubleJumping)
			{
				_boosterTime = 120;
				_isDoubleJumping = false;
				_canDoubleJump = false;
				_upReleasedInAir = false;
				_boosterParticleSystem.stop();
				TweenLite.to(this, 0.25, { rotation:0 } );
			}
			else if (ySpeed < 0)
			{
				_upReleasedInAir = true;
			}
		}
		
		private function kDown(e:KeyboardEvent):void 
		{
			_currentlyJumpIsDown = true;
			if(_hasLandedSinceJump)
				_lastJumpTimestamp = getTimer();
		}
		
		public function frame(collidedWith:TileGroup):void 
		{
			if (collidedWith != null)
			{
				y = collidedWith.y - collidedWith.height + 1;
				_ySpeed = 0;
				_hasLandedSinceJump = true;
				
				_canDoubleJump = false;
				
				if (getTimer() - _lastJumpTimestamp < 16 * 5)
				{
					_ySpeed = -_jumpPower;
					_burstParticleSystem.start(0.1);
					_upReleasedInAir = false;
				}
			
			}
			else if (_ySpeed < 0 && _currentlyJumpIsDown && _frameCountFromJump < 9)
			{
				_ySpeed -= 0.15 * (9 - _frameCountFromJump)////1 * Math.pow(1 - .05, (getTimer() - _lastJumpTimestamp));// / 200;
			}
			else if (_isDoubleJumping)
			{
				_boosterTime--;
				if (_boosterTime <= 0)
				{
					_boosterTime = 120;
					_isDoubleJumping = false;
					_canDoubleJump = false;
					_upReleasedInAir = false;
					_boosterParticleSystem.stop();
					TweenLite.to(this, 0.25, { rotation:0 } );
				}
			}
			else
			{
				_ySpeed += _gravity; 
			}
			
			if (_ySpeed < 0)
			{
				_frameCountFromJump++;
				
				if (!_canDoubleJump && _frameCountFromJump > 4)
				{
					_canDoubleJump = true;
				}
				trace("Can double jump?", _canDoubleJump);
				if (_upReleasedInAir &&  _currentlyJumpIsDown && _canDoubleJump)
				{
					_upReleasedInAir = false;
					_canDoubleJump = false;
					_isDoubleJumping = true;
					_boosterParticleSystem.start();
					
					TweenLite.to(this, 0.25, { rotation:Math.PI/4 } );
					
				}
			}
			else
				_frameCountFromJump = 0;
			
			
		
			y += _ySpeed;
			
			_burstParticleSystem.emitterX = x;
			_burstParticleSystem.emitterY = y;
		}
		
		public function get ySpeed():Number { return _ySpeed; }
	}

}