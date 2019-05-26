package
{
	import com.junkbyte.console.Cc;
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import starling.core.Starling;
	import flash.display3D.Context3DRenderMode;
	
	/**
	 * ...
	 * @author General
	 */
	public class Main extends Sprite 
	{
		public static var _starling:Starling;		
		public static var self:Main;		
		public function Main() 
		{
			Cc.startOnStage(this);
			Cc.listenUncaughtErrors(this.loaderInfo);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			//stage.addEventListener(Event.RESIZE, onStageResized);
			
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			//NativeApplication.nativeApplication.addEventListener(Event.EXITING, exitHandler);
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			Starling.multitouchEnabled = true;
			// entry point
			
			//CONFIG::isPCVersion{
			//	stage.scaleMode = StageScaleMode.SHOW_ALL;
			//	stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			//}
			//Моя функция подгонки под разные размеры экрана
			ConstLibrary.setupScales(stage);
			//Starling.handleLostContext = true;//нужно, чтобы после после возвращения из сворачивания всё работало
			
			//задаём порт вывода для Старлинга - он будет показываться на весь экран реального устройства
			var port:Rectangle = new Rectangle(0, 0, ConstLibrary.screenW, ConstLibrary.screenH);
			
			// entry point
			//StarApp - класс самого приложения
			_starling = new Starling(StarApp, this.stage, port, null, Context3DRenderMode.AUTO);
			_starling.showStats = false;//*/true;//показывать ли ФПС
			_starling.simulateMultitouch = true;
			//adaptive screen:
			
			_starling.stage.stageWidth = ConstLibrary.gameWidth;
			_starling.stage.stageHeight = ConstLibrary.gameHeight;
			//CONFIG::isPCVersion{
			//	_starling.stage.stageHeight = 960;
			//	_starling.stage.stageWidth = ConstLibrary.gameWidth / ConstLibrary.gameHeight * 960;
			//}
			
			
			_starling.start();
			
			// new to AIR? please read *carefully* the readme.txt files!
			
			
		}
		
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		
	}
	
}