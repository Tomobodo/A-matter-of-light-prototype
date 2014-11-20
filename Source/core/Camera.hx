package core;
import geom.Vec2;
import haxe.Timer;

/**
 * ...
 * @author Thomas BAUDON
 */
class Camera
{
	
	var mTargetEntity : Entity;
	var mShakeIntensity:Int;
	var mShakeTime:Int;
	var mShakePhase : Int;
	var mShakeOffsetX : Int;
	var mShakeOffsetY : Int;
	var mShaking : Bool;
	var mGame : Game;
	
	public var pos : Vec2;

	public function new() 
	{
		pos = new Vec2();
		mGame = Game.getInstance();
	}
	
	public function setTarget(ent : Entity) {
		mTargetEntity = ent;
	}
	
	public function update(delta : Float) {
		if (mTargetEntity != null) {
			pos.x = mTargetEntity.pos.x + (mTargetEntity.getDim().x - mGame.getWidth()) / 2;
			pos.y = mTargetEntity.pos.y + (mTargetEntity.getDim().y - mGame.getHeight()) / 2;
		}
		
		if (mShaking || mShakePhase == 1)
		{
			if (mShakePhase == 0) {
				mShakeOffsetX = cast Math.random() * mShakeIntensity * 2 - mShakeIntensity;
				mShakeOffsetY = cast Math.random() * mShakeIntensity * 2 - mShakeIntensity;
			}else {
				mShakeOffsetX = -mShakeOffsetX;
				mShakeOffsetY = -mShakeOffsetY;
			}
			
			pos.x += mShakeOffsetX;
			pos.y += mShakeOffsetY;
			
			mShakeTime -= cast 1000 * delta;
			
			if (!mShaking) {
				if(mShakePhase == 0){
					pos.x -= mShakeOffsetX;
					pos.y -= mShakeOffsetY;
				}
			}
			mShakePhase ++;
			if (mShakePhase > 1)
				mShakePhase = 0;
		}
	}
	
	public function shake(intensity : Int, time : Int) {
		startShake(intensity);
		Timer.delay(stopShake, time);
	}
	
	public function startShake(intensity : Int) {
		mShaking = true;
		mShakePhase = 0;
		mShakeIntensity = intensity;
	}
	
	public function stopShake() {
		mShaking = false;
	}
	
}