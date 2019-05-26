package  
{
	import com.junkbyte.console.Cc;
	
	import starling.textures.Texture;
	import starling.assets.AssetManager;
	
	import flash.filesystem.File;
	
	/**
	 * ...
	 * @author General
	 */
	public class Assets 
	{
		static public var	TXS_ASFONT	:Vector.<Texture>;							
		static public var	TXS_MYFONT	:Vector.<Texture>;							
		
		static public var	TEX_IDEABULB:Texture;
		
		static public var	TEX_SPEECHBUBBLE:Texture;
		static public var	TXS_FACES:Vector.<Texture>;
		public static var fontsSelection:Array = [
		//lat, cyr
			//["BloggerSansBold","BloggerSansBold"],
			//["BloggerSansLight","BloggerSansLight"]
		]
		
		public static var manager:AssetManager;//подгрузак текстур
		
		public function Assets() 
		{
			
		}
		
		public static function init(wid:int):void {
			Cc.log('assets init');
			//загружаем картинки и звуки из папки приложения /data
			manager = new AssetManager();
			manager.verbose = true;
			
			//CONFIG::isMobileVersion{
				var appDir:File = File.applicationDirectory;
				manager.enqueue(appDir.resolvePath("data/all"));
				
			//	manager.enqueue(appDir.resolvePath("data/"+wid.toString()));
			//}
			//CONFIG::isWebVersion{
			//	manager.enqueue(localparams.AssetsList);
			//	manager.enqueue(WorldsAssetsList.getAssets4World(wid));
			//}

			//manager.loadQueue(prepare2LoadNew);
			//var pegLeg:AssetLoaderPegLeg = new AssetLoaderPegLeg();
			//manager.loadQueue(pegLeg.loadAseetsCallback);//что должно произовйти, пока грузятся картинки
			manager.loadQueue(StarApp.app.onAssetsLoadComplete,StarApp.app.onAssetsLoadError, StarApp.app.onAssetsLoadProgress);//что должно произовйти, пока грузятся картинки
		}
		
		
	
		
		
		public static function setVariables():void {
		
			////////////////////////////////////////////////////////////////
			TXS_ASFONT = manager.getTextures('FontAsia4nxt');
		
			TEX_IDEABULB 	 = manager.getTexture('wadd_ideaBulb4new0000');
			TEX_SPEECHBUBBLE  = manager.getTexture('wadd_speechBubble4new0000');
			TXS_FACES 	 = manager.getTextures('wadd_faces4new');
			
		}

	}
}