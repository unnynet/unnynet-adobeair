package com.unnynet.air 
{
	import com.junkbyte.console.Cc;
	import com.tuarua.WebViewANE;
	import com.tuarua.webview.Settings;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import starling.core.Starling;
	/**
	 * ...
	 * @author ...
	 */
	public class UnnyNet 
	{
		private var webView:WebViewANE;
		
		private var version:int = 2;
		private var gameCode:String = '';
		private var myStage:Stage;
		private var scaleFactor:Number=1;
		
		private var chatRectOnScreen:Rectangle = null;
		private var closeBtn:Sprite;
		private var topCoverStripe:Sprite;
		public function UnnyNet(stg:Stage, cd:String, ver:int=2) 
		{
			myStage = stg;
			gameCode = cd;
			version = ver;
			chatRectOnScreen = new Rectangle(0, 0, myStage.stageWidth, myStage.stageHeight);
			closeBtn = new Sprite();
			var shp:Shape = new Shape();
			shp.graphics.beginFill(0xffff0000);
			shp.graphics.drawCircle(0, 0, 50);
			shp.graphics.endFill();
			closeBtn.addChild(shp);
			
			
			closeBtn.addEventListener(MouseEvent.CLICK, onCloseClick);
			
			
			
		}
		
		private function onCloseClick(e:MouseEvent):void 
		{
			hide();
		}
		
		public function hide():void 
		{
			if (webView){
				webView.visible = false;
			}
			if (closeBtn.parent){
				closeBtn.parent.removeChild(closeBtn);
			}
			if (topCoverStripe.parent){
				topCoverStripe.parent.removeChild(topCoverStripe);
			}
		}
		
		public function setWebViewScaleFactor(scl:Number):void{
			scaleFactor = scl;
		}
		
		public function setChatRectOnScreen(rct:Rectangle):void{
			chatRectOnScreen.copyFrom(rct);
		}
		
		public function show():void 
		{
			if (!webView){
				initialize();
			}
			webView.visible = true;
			
			closeBtn.x = chatRectOnScreen.right-50;
			closeBtn.y = chatRectOnScreen.top*0.5;//на середине полосы
			
			//myStage.addChild(closeBtn);
			initDarkTopSide();

			Starling.current.nativeOverlayBlocksTouches = true;
			Starling.current.nativeOverlay.addChild(topCoverStripe);
			Starling.current.nativeOverlay.addChild(closeBtn);
			//Cc.log(closeBtn.parent);
			//Cc.log(closeBtn.x);
			//Cc.log(closeBtn.y);
			//Cc.log(closeBtn.width);
			//Cc.log(closeBtn.height);
		}
		
		private function initDarkTopSide():void 
		{
			if (!topCoverStripe){
				topCoverStripe = new Sprite();
				var shp:Shape = new Shape();
				shp.graphics.beginFill(0xff36393f);
				shp.graphics.drawRect(0, 0, chatRectOnScreen.width, chatRectOnScreen.top);
				shp.graphics.endFill();
				topCoverStripe.addChild(shp);				
			}

		}
		
		public function initialize():void 
		{
			webView = new WebViewANE();
			var settings:Settings = new Settings();
			settings.webkit.allowsInlineMediaPlayback = true;
			settings.webkit.bounces = false;

			
			webView.init(myStage, chatRectOnScreen, new URLRequest("https://unnynet.com/#/plugin/"+gameCode+"?version="+version.toString()),
				settings, scaleFactor, 0x00F1F1F1);
				
				
		}
		
	}

}