package com.truex.api
{
	import flash.utils.Proxy;

	dynamic public class TxTracker extends Proxy
	{
		private var _api:*;
		
		public function TxTracker(api:*)
		{
			_api = api;
		}
		
		/**
		 * Tracks user navigating to the next step in an engagement flow
		 * 
		 * @param label used to identify the step navigating to (i.e. 'step 2')
		 *
		 **/
		public function navigationNext(label:String = null):void { _api.trackInteraction('navigation', 'next', label); }
		
		/**
		 * Tracks user navigating to an arbitrary step in an engagement flow
		 * 
		 * @param label used to identify the step navigating to (i.e. 'step 5')
		 *
		 **/
		public function navigationGoto(label:String = null):void { _api.trackInteraction('navigation', 'goto', label); }
		
		/**
		 * Tracks user skipping a particular step or action in an engagement flow.  A typical example is skipping a
		 * step in the engagement that asks the user to share on Facebook.
		 * 
		 * @param label used to identify the skipped action (i.e. 'facebook_share')
		 *
		 **/
		public function navigationSkip(label:String = null):void { _api.trackInteraction('navigation', 'skip', label); }
		
		/**
		 * Tracks the user interaction bringing up a dialog within the engagement
		 * 
		 * @param label used to identify the dialog (i.e. 'more_info')
		 *
		 **/
		public function navigationDialog(label:String = null):void { _api.trackInteraction('navigation', 'dialog', label); }
		
		
		/**
		 * Tracks video started
		 * 
		 * @param label used to identify the video (i.e. cat_video)
		 *
		 **/
		public function videoStarted(label:String = null):void { _api.trackInteraction('multimedia', 'video_started', label); }
		
		/**
		 * Tracks video 1st quartile (25%)
		 * 
		 * @param label used to identify the video (i.e. cat_video)
		 *
		 **/
		public function videoFirstQuartile(label:String = null):void { _api.trackInteraction('multimedia', 'video_first_quartile', label); }
		
		/**
		 * Tracks video 2nd quartile, mid point (50%)
		 * 
		 * @param label used to identify the video (i.e. cat_video)
		 *
		 **/
		public function videoSecondQuartile(label:String = null):void { _api.trackInteraction('multimedia', 'video_second_quartile', label); }
		
		/**
		 * Tracks video 3rd quartile (75%)
		 * 
		 * @param label used to identify the video (i.e. cat_video)
		 *
		 **/
		public function videoThirdQuartile(label:String = null):void { _api.trackInteraction('multimedia', 'video_third_quartile', label); }
		
		/**
		 * Tracks video completed
		 * 
		 * @param label used to identify the video (i.e. cat_video)
		 *
		 **/
		public function videoCompleted(label:String = null):void { _api.trackInteraction('multimedia', 'video_completed', label); }
		
		/**
		 * Tracks video replay
		 * 
		 * @param label used to identify the video (i.e. cat_video)
		 *
		 **/
		public function videoReplay(label:String = null):void { _api.trackInteraction('multimedia', 'video_replay', label); }
		
		
		/**
		 * Tracks game started
		 * 
		 * @param label used to identify the game (i.e. puzzle)
		 *
		 **/
		public function gameStarted(label:String = null):void { _api.trackInteraction('multimedia', 'game_started', label); }
		
		/**
		 * Tracks game completed
		 * 
		 * @param label used to identify the game (i.e. puzzle)
		 *
		 **/
		public function gameCompleted(label:String = null):void { _api.trackInteraction('multimedia', 'game_completed', label); }
		
		/**
		 * Tracks game replay
		 * 
		 * @param label used to identify the game (i.e. puzzle)
		 *
		 **/
		public function gameReplay(label:String = null):void { _api.trackInteraction('multimedia', 'game_replay', label); }
		
		
		/**
		 * Tracks when a website URL is clicked out to
		 * 
		 * @param url the website url that is popped up (i.e. http://www.brand.com)
		 *
		 **/
		public function popupWebsite(url:String = null):void { _api.trackInteraction('external', 'website', url); }
		
		/**
		 * Tracks when a Facebook page is clicked out to
		 * 
		 * @param url the Facebook url that is popped up (i.e. http://www.facebook.com/brand)
		 *
		 **/
		public function popupFacebookPage(url:String = null):void { _api.trackInteraction('external', 'fb_fan_page', url); }
		
		/**
		 * Tracks add to calendar action
		 * 
		 * @param label used to identify the event (i.e. tune_in_tomorrow)
		 *
		 **/
		public function addToCalendar(label:String = null):void { _api.trackInteraction('external', 'add_to_calendar', label); }
		
		/**
		 * Tracks download action
		 * 
		 * @param url the URL of the downloaded content
		 *
		 **/
		public function download(url:String = null):void { _api.trackInteraction('external', 'download', url); }
		
		/**
		 * Tracks print action
		 * 
		 * @param label used to identify the printed material (i.e. cake_recipe)
		 *
		 **/
		public function print(label:String = null):void { _api.trackInteraction('external', 'print', label); }
		
		
		/**
		 * Tracks user data entry of zipcode
		 * 
		 * @param zipcode the zipcode submitted
		 *
		 **/
		public function submitZipcode(zipcode:String = null):void { _api.trackInteraction('data_entry', 'zipcode', zipcode); }
		
		/**
		 * Tracks user data entry of email
		 * 
		 * @param email the email submitted
		 *
		 **/
		public function submitEmail(email:String = null):void { _api.trackInteraction('data_entry', 'email', email); }
		
		/**
		 * Tracks user data entry of name
		 * 
		 * @param name the name submitted
		 *
		 **/
		public function submitName(name:String = null):void { _api.trackInteraction('data_entry', 'name', name); }
		
		/**
		 * Tracks user upload of content
		 * 
		 * @param label a label identifying the uploaded content.  Typically, a URL of the content (i.e. photo upload URL)
		 *
		 **/
		public function upload(label:String = null):void { _api.trackInteraction('data_entry', 'upload', label); }
		
		
		/**
		 * Tracks an aggregate form of user interactions.  A use-case for this is when sometime might generate many integrations, like a game,
		 * and you just want to track how many times a user interacts within the game.
		 * 
		 * @param name a label that is used in reports to identify the type of aggregate interaction (i.e. 'game jumps').
		 * @param interactionCount the total count of user interactions for this aggregate interaction.
		 *
		 **/
		public function aggregate(name:String, interactionCount:Number):void { _api.trackInteraction('aggregate', name, interactionCount); }
		
		
		/**
		 * A catch-all tracking function for all other types of user interactions.  Use this when you want to track something that
		 * is not covered by the other specific tracking functions.
		 * 
		 * @param name a label that is used in reports to identify this user interaction (i.e. 'google maps').
		 * @param value another label that is used in reports to further identify this 'other' interaction (i.e. 'search').
		 *
		 **/
		public function other(name:String, value:String = null):void { _api.trackInteraction('other', name, value); }
	}
}