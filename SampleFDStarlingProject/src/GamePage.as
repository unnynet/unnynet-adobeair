package 
{
	import com.junkbyte.console.Cc;
	import com.tuarua.WebViewANE;
	import com.tuarua.webview.JavascriptResult;
	import com.tuarua.webview.Settings;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	import flash.net.URLRequest;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	/**
	 * ...
	 * @author General
	 */
	public class GamePage extends Sprite
	{
		private var im1:Image;
		private var im2:Image;
		private var im3:Image;
		private var im4:Image;
		private var webView:WebViewANE;
		
		public function GamePage() 
		{
			im1 = new Image(Assets.TXS_FACES[0]);
			im1.x = ConstLibrary.gameWidth * 0.25;
			im1.y = ConstLibrary.gameHeight * 0.25;
			addChild(im1);
			
			im2 = new Image(Assets.TXS_FACES[1]);
			im2.x = ConstLibrary.gameWidth * 0.75;
			im2.y = ConstLibrary.gameHeight * 0.25;
			addChild(im2);
			
			im3 = new Image(Assets.TXS_FACES[2]);
			im3.x = ConstLibrary.gameWidth * 0.25;
			im3.y = ConstLibrary.gameHeight * 0.5;
			addChild(im3);	
			
			im4 = new Image(Assets.TXS_FACES[3]);
			im4.x = ConstLibrary.gameWidth * 0.75;
			im4.y = ConstLibrary.gameHeight * 0.5;
			addChild(im4);
			
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			if (e){
				var tch:Touch = e.getTouch(this, TouchPhase.BEGAN);
				if (tch){
					if (tch.target == im1){
						trace('Im1');
						showWebView();
					}
					if (tch.target == im2){
						trace('Im2');
						showLeaderboards()
					}
					if (tch.target == im3){
						trace('Im3');
						sendScore()
					}
				}
			}
		}
		
		private function sendScore():void 
		{
			if (webView){
				Cc.log('Caling js...');
				webView.callJavascriptFunction('window.globalReactFunctions.apiReportLeaderboardScores', onJSCalled,'test Leaderboard',int(Math.random()*100).toString());	
			}
		}		
		private function showLeaderboards():void 
		{
			if (webView){
				Cc.log('Caling js...');
				webView.callJavascriptFunction('window.globalReactFunctions.apiOpenLeaderboards', onJSCalled);	
			}
		}
		
		public function onJSCalled(str:JavascriptResult=null):void 
		{
			Cc.log('JS called:',str.error, str.message, str.result, str.success);
		}
		
		private function showWebView():void 
		{
			//var wv:StageWebView = new StageWebView(true);
			webView = new WebViewANE();
			var settings:Settings = new Settings();
			settings.webkit.allowsInlineMediaPlayback = true;
			settings.webkit.bounces = false;

			
			var viewPort:Rectangle = new Rectangle(0, stage.stageHeight/2, stage.stageWidth, (stage.stageHeight/2));
			webView.init(Starling.current.nativeStage, viewPort, new URLRequest("https://unnynet.com/#/plugin/11b426cf-d486-465f-a5d5-174d68c85cfe?version=2"),
			//webView.init(Starling.current.nativeStage, viewPort, new URLRequest("https://unnynet.com/#/plugin/6acee736-da50-45dd-a809-f3472dee9192?version=2"),
                settings, Starling.current.contentScaleFactor, 0x00F1F1F1);
			webView.visible = true;
		}
		
	}

}