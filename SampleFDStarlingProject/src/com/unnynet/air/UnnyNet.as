package com.unnynet.air 
{
	import com.junkbyte.console.Cc;
	import com.tuarua.WebViewANE;
	import com.tuarua.webview.JavascriptResult;
	import com.tuarua.webview.ActionscriptCallback;
	import com.tuarua.webview.WebViewEvent;
	import com.tuarua.webview.Settings;
	import flash.display.MovieClip;
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
		private var closeBtn:MovieClip;
		private var topCoverStripe:Sprite;
		public function UnnyNet(stg:Stage, cd:String, ver:int=2) 
		{
			myStage = stg;
			gameCode = cd;
			version = ver;
			chatRectOnScreen = new Rectangle(0, 0, myStage.stageWidth, myStage.stageHeight);
			closeBtn = new UniButtonSprites();
			closeBtn.addEventListener(MouseEvent.CLICK, onCloseClick);
			
			closeBtn.width = closeBtn.height = 100;
			closeBtn.stop();
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
			//if (!webView){
			//	initialize();
			//}
			//webView.visible = true;
			
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
				shp.graphics.drawRect(0, 0, chatRectOnScreen.width, chatRectOnScreen.top+10);
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

			webView.addCallback("window.globalReactFunctions.apiSendMessage", jsToAsCallback);
			webView.addCallback("window.globalReactFunctions.apiSendSystemMessage", jsToAsCallback);
			webView.addCallback("window.globalReactFunctions.apiSendUnityMessage", jsToAsCallback);
			webView.init(myStage, chatRectOnScreen, new URLRequest("https://unnynet.com/#/plugin/"+gameCode+"?version="+version.toString()),
				settings, scaleFactor, 0x00F1F1F1);
				
			webView.addEventListener(WebViewEvent.ON_PROPERTY_CHANGE, onWebViewPropertyChange);
			
		}
		
		public function jsToAsCallback(asCallback:ActionscriptCallback):void {
			Cc.log("JS -> AS reached StarlingRoot.as");
			Cc.log("asCallback.args", asCallback.args);
			Cc.log("asCallback.functionName", asCallback.functionName);
			Cc.log("asCallback.callbackName", asCallback.callbackName);

			if (asCallback.args && asCallback.args.length > 0) {
				var paramA:int = asCallback.args[0] + 33;
				var paramB:String = asCallback.args[1].replace("I am", "You are");
				var paramC:Boolean = !asCallback.args[2];

				Cc.log("paramA", paramA);
				Cc.log("paramB", paramB);
				Cc.log("paramC", paramC);
				Cc.log("we have a callbackName")
			}


			if (asCallback.callbackName) { //if we have a callbackName it means we have a further js call to make
				webView.callJavascriptFunction(asCallback.callbackName, null, paramA, paramB, paramC);
			}

		}
		
		private function onWebViewPropertyChange(e:WebViewEvent):void 
		{
			Cc.log("");
			Cc.log(e.params.propertyName, "has changed:", "to", e.params.value);
			Cc.log(e.params);
			Cc.log("------");			
		}
		
	}

}