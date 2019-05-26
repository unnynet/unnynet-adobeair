package 
{
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	
	/**
	 * ...
	 * @author Alexey Izvalov
	 */
	public class ConstLibrary 
	{
		public static var versionNum:String = '0.0.1';
		public static var saveNum:String = '0.0.1';

		public static var fitterWidth:int = 600;//у вертикальных частей внутри альбомного экрана
		public static var gameWidth:int = 600;//какие размеры будут у игры с учётом размеров экрана
		public static var gameHeight:int = 800;		
		public static var sideField:int = 0;		
		//
		public static var W0:int = 600;//под какой размер проектируется игра	
		public static var H0:int = 800;	
		
		//public static var W0:int = 1024;//под какой размер проектируется игра	
		//public static var H0:int = 768;		
		
		public static var screenW:int = 600;//реальный размер экрана устройства
		public static var screenH:int = 800;
		public static var ratio:Number = 1.3333;//соотношение между высотой и шириной, поменяется при инициализации
		public static var screenPixelsInGameRatio:Number = 1;//сколько экранных пикселей в игровом
		
		
		public function ConstLibrary(){
			
		}
		
		
		static public function setupScales(stg:Stage):void 
		{
			//trace('setupScales');
			//trace('stg.fullScreenWidth:',stg.fullScreenWidth);
			//trace('stg.fullScreenHeight:',stg.fullScreenHeight);
			
			//if (Main.self.isWebVersion){
			//	var t:int = gameWidth;
			//	gameWidth = gameHeight;
			//	gameHeight = t;
			//	
			//}
			//if (Main.self.isWebVersion){
			//	W0 = 1024;
			//	H0 = 768;				
			//	//W0 = 800;
			//	//H0 = 600;
			////	CONFIG::isPCVersion{
			//		W0 = 720;
			//		H0 = 960;
			////	}
			//}else{
				//isNewScreen
					W0 = 720;
					H0 = 960;

			//}
			
			//if (Main.self.isWebVersion){
			//	screenW = stg.stageWidth;
			//	screenH = stg.stageHeight;					
			//	CONFIG::isPCVersion{
			//		screenW = stg.fullScreenWidth;
			//		screenH = stg.fullScreenHeight;						
			//	}
			//
			//}else{
				screenW = stg.fullScreenWidth;
				screenH = stg.fullScreenHeight;				
			//}
			
			//screenW = stg.stageWidth;
			//screenH = stg.stageHeight;

			ratio = screenH / screenW;
			if ((ratio >= 1)/*||(Main.self.isWebVersion&&!Main.self.isPCVersion)*/){
				gameWidth = W0;
				gameHeight = gameWidth * ratio;	
				fitterWidth = gameWidth;
			}else{
				gameHeight = H0;
				gameWidth = gameHeight / ratio;
				fitterWidth = gameHeight / 4 * 3;
			}
			//if ((Main.self.isWebVersion && !Main.self.isPCVersion)){
			//	fitterWidth = gameWidth;//а почему это я для веба ствлю фиттер аткой широкий?пожалуй, это попало с едоков, они ж тонкие...
			//}else{
			//	fitterWidth = gameHeight / 4 * 3;
			//}
			
			if (fitterWidth > gameWidth){
				fitterWidth = gameWidth;
			}
			sideField = (gameWidth - fitterWidth) / 2;	
			
			screenPixelsInGameRatio = screenH / gameHeight;
		}
		

		
	}

}