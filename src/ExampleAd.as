package
{
	import com.truex.api.IEngagement;
	import com.truex.api.TxProxy;

	import flash.display.Sprite;
	import flash.system.Security;
	
	public class ExampleAd extends Sprite implements IEngagement
	{
		protected var _api:TxProxy = new TxProxy(this);
		
		public function ExampleAd()
		{
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			
			// Note: do not reference 'stage' in constructor since it will be null.
		}
		
		// when this ad is added to stage, your engagement should render and start any videos/sounds/animation
		public function onEngagementStart():void
		{
			// your ad should begin here
		}
		
		// when this ad is removed from stage, it should stop videos/sound/animation and remove any event listeners.
		public function onEngagementEnd():void
		{
			// stop any running videos or sounds
		}
		
		
		// user wishes to pause the unit, please pause any running videos or sounds
		public function onEngagementPause():void
		{
			// pause videos or sounds
		}
		
		// user wishes to resume the unit, please resume any paused videos or sounds
		public function onEngagementResume():void
		{
			// resume videos or sounds
		}
		
		// user wishes to change volume, please adjust the volume on any running videos or sounds
		public function onEngagementVolumeChange():void
		{
			// adjust volume on videos or sounds
		}
	}
}

