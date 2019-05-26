package 
{
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author General
	 */
	public class AppPreloader extends Sprite
	{
		public var gameLogo:Image;
		public var airapportLogo:Image;
		public var gauge:Image;
		public function AppPreloader() 
		{
			
		}
		public function registerImages(gl:Image, al:Image, gg:Image):void{
			gameLogo = gl;
			airapportLogo = al;
			gauge = gg;
		}
		
	}

}