package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.AccelerometerEvent;
	import flash.sensors.Accelerometer;
	import flash.system.Capabilities;
	import flash.utils.getTimer;


	//import screens.DefeatScreen;

	import starling.display.Image;
	import starling.display.Sprite;
	import com.junkbyte.console.Cc;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Alexey Izvalov
	 */
	public class StarApp extends Sprite //обрати внимание - starling.display.Sprite, не flash.display.Sprite;
	{
		//синглтон - ссылка на единственный экземпляр класса StarApp. Потом можно обратиться StarApp.app
		public static var app:StarApp;
		
		//индикация загрузки
		public var preloader:AppPreloader;
		private var gauge:Image;
		
		

		public function StarApp() 
		{
			//создаём индикатор загрузки
			Cc.log('preloader');
			
			makePreloader();
			app = this;//чтобы другие объекты могли достучаться до нашего через StarApp.app
			Assets.init(0);
		}
		
		private function makePreloader():void 
		{
			preloader = new AppPreloader();
			addChild(preloader);
			//Cc.log('DataShareNativeExtImage');
			
			
			[Embed(source="../start_img/redBGD_init.png")]//изображение вшивается в программу, в свф-файл
			var startupBG:Class;
			
			var img:Image = new Image(Texture.fromBitmap(new startupBG(), false));//создаётся картинка
			img.width = ConstLibrary.gameWidth;
			img.height = ConstLibrary.gameHeight;
			preloader.addChild(img);
			
			[Embed(source="../start_img/logo_init.png")]
			var startupLogo:Class;
			var img2:Image = new Image(Texture.fromBitmap(new startupLogo(), false));
			//trace('logo created');
			img2.alignPivot();//чтобы точка привязки была в центре.
			img2.x = ConstLibrary.gameWidth / 2;
			img2.y = ConstLibrary.gameHeight * 0.6;
			//trace(img2.x, img2.y);
			//img2.scaleX = img2.scaleY = ConstLibrary.gameWidth / ConstLibrary.screenW;
			preloader.addChild(img2);	
			
			[Embed(source="../start_img/LogoWithOutlineEngineer.png")]
			var startupGameLogoEngineer:Class;
			
			
			
			var img3:Image = new Image(Texture.fromBitmap(new startupGameLogoEngineer(), false));
			
			
			//trace('logo created');
			img3.alignPivot();//чтобы точка привязки была в центре.
			img3.x = ConstLibrary.gameWidth / 2;
			img3.y = ConstLibrary.gameHeight * 0.3;
			//trace(img2.x, img2.y);
			//img2.scaleX = img2.scaleY = ConstLibrary.gameWidth / ConstLibrary.screenW;
			preloader.addChild(img3);			
			
			[Embed(source="../start_img/gauge_init.png")]
			var startupGauge:Class;			
			gauge = new Image(Texture.fromBitmap(new startupGauge(), false));
			gauge.x = ConstLibrary.gameWidth * 0.05;
			gauge.y = ConstLibrary.gameHeight * 0.95;
			gauge.alignPivot("left", "top");
			gauge.width = 0;
			preloader.addChild(gauge);
			Cc.log('app');		
			
			preloader.registerImages(img3, img2, gauge);
		}
		
		public function showLoadProgress(ratio:Number):void{
			gauge.width = ConstLibrary.gameWidth * 0.9 * ratio;
		}	
		
		public function react2FullLoad():void{
			Cc.log('react2FullLoad');
			continueLoading();
		}
		
		public function onAssetsLoadProgress(ratio:Number):void {
			gauge.width = ConstLibrary.gameWidth * 0.9 * ratio;
		}		
		public function onAssetsLoadError(error:String):void {
			
		}		
		public function onAssetsLoadComplete():void {
			continueLoading();
		}
		
		public function onAdditionalAssetsLoadProgress(ratio:Number):void {
			gauge.width = ConstLibrary.gameWidth * 0.9 * ratio;
			trace('onAdditionalAssetsLoadProgress', ratio)
		}		
		public function onAdditionalAssetsLoadError(error:String):void {
			trace('onAdditionalAssetsLoadError', error)
		}		


		private function continueLoading():void 
		{
			Cc.log('continueLoading');
			//return;
			Assets.setVariables();
			

			removeChild(preloader);
			//preloader = null;
			
			var pg:GamePage = new GamePage();
			addChild(pg);
			
			Cc.log('OKOKOK');
		}
		
	
	}
}