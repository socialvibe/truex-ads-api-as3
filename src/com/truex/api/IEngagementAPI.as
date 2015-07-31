package com.truex.api
{
	public interface IEngagementAPI
	{
		/**
		 *  A hash object containing various runtime ad paramters.
		 *
		 **/
		function get params():*;
		function getParams(name:*):*;
		function setParams(name:*, value:*):void;
		
		
		/* =================================
		PRELOADING API
		================================= */
		
		/**
		 * An event handler function that is called to start the preload phase of an engagement.
		 * If this handler is set, calls to updatePreloadProgress and preloadCompleted are expected to
		 * signal progress and completion of preloading.
		 *
		 **/
		function set preloadHandler(handler:Function):void;
		
		/**
		 *  Signals the preload progress. percent should be a decimal within 0.0 and 1.0.
		 *
		 **/
		function updatePreloadProgress(percent:Number):void;
		
		/**
		 *  Signals that preload is complete and the engagement is ready to start.
		 *
		 **/
		function preloadCompleted():void;
		
		
		/* =================================
		STEP MANAGEMENT API
		================================= */
		
		/**
		 * totalStepCount is the total number of steps in an engagement.  This value is used to determine the progress
		 * of the user through the engagement and to determine when the user has gotten to the last step.
		 * 
		 **/
		function set totalStepCount(count:int):void;
		
		/**
		 * currentStep is the the current index of the step of an engagement, starting at 1.  The step index is 
		 * used internally to track performance of user flow.  For example, we use step index to know where a user 
		 * drops off, which steps have the most interaction, etc.  The value should be between 1-999.
		 * 
		 **/
		function set currentStep(index:int):void;
		
		function get currentStep():int;
		
		/**
		 * Increments the current step index of this engagement.  The step index is used internally to track performance
		 * of user flow.
		 * 
		 **/
		function incrementCurrentStep():void;
		
		/**
		 * Signals that the end of the engagement has been reached.  The ad container will end the experience once this is called.
		 * 
		 **/
		function endEngage():void;
		
		
		/* =================================
		EVENT DISPATCHING API
		================================= */
		function dispatchContainerEvent(event:String, data:Object = null):void;
		function addContainerListener(event:String, callback:Function):void;
		function removeContainerListener(event:String):void;
		
		/* =================================
		TRACKING API
		================================= */
		
		/**
		 * Tracks a single user interaction.
		 * 
		 * @param category a label that is used in reports to identify the category of this user interaction (i.e. 'map').
		 * @param name a label that is used in reports to identify this user interaction within a category (i.e. 'search').
		 * @param value another label that is used in reports to further identify this interaction (i.e. 'Los Angeles, CA').
		 *
		 **/
		function trackInteraction(category:String, name:String, value:Object = null):void;
		
		/**
		 * Returns an instance of TxTracker which can be used as a helper to track the standard set of TrueX tracked interactions.
		 * 
		 **/
		function get track():TxTracker;
		
		
		/* =================================
		USER DATA API
		================================= */
		/**
		 * Saves comment data made by the user.  Upon completion of the engagement (i.e. when engage() is called), this comment data
		 * is saved to our system.
		 * 
		 * @param comment a user inputed string of any length.
		 * @param label an identifier for the data (i.e. 'email', 'answer1', etc).
		 *
		 **/
		function saveCommentData(comment:String, label:String = null):void;
		
		/**
		 * Saves vote data made by the user.  Upon completion of the engagement (i.e. when engage() is called), this vote data
		 * is saved to our system.
		 * 
		 * @param category a number representing the index of the question the user is answering (typically '1' for the first question, '2' for the second question).
		 * @param label a string representation of the answer choice (typically the actual answer choice text).
		 * @param vote a numerical representation of the answer choice.  This number must be unique across all answer choices and all question categories.  For example, 
		 * for a 2-question poll with 4 answer options for each question, the vote value for the first answer on the first question is typically '1' and the first 
		 * answer on the second question is typically '5'.
		 *
		 **/
		function saveVoteData(category:Number, label:String, vote:Number):void;
		
		/**
		 * Retrieves the last 5 comments made by users who have completed this engagement.  Note: there is a 15 minute cache delay on the data.
		 * The structure of the comment data returned is an array of objects with a 'body' and 'ago' fields, like so:
		 * {body:"COMMENT_TEXT", ago:"31 minutes ago"}
		 * 
		 * @return an Array of comment data Objects. 
		 **/
		function getRecentComments():Array;
		
		/**
		 * Retrieves all vote data of users who have completed this engagement.  Note: there is a 15 minute cache delay on the data.
		 * The structure of the vote data returned is an array of Objects with a 'category', 'vote', 'label', and 'vote_count' fields, like so:
		 * {category:"1", label:"FIRST ANSWER CHOICE FROM THE FIRST QUESTION", vote:"1", vote_count:"25023"}
		 * 
		 * @return an Array of vote data Objects. 
		 **/
		function getVoteSummary():Array;
		
		
		/* =================================
		SOCIAL API
		================================= */
		
		/**
		 * Pops up the Facebook share feed dialog.  The Facebook share interaction is also tracked when 
		 * this is called.
		 *
		 * @param url the url to share on Facebook
		 * @param title the title name of the url which is shared on Facebook
		 * @param caption the caption of the link (appears beneath the title). If not specified, this field is automatically populated with the URL of the link.
		 * @param description the description of the link (appears beneath the link caption).
		 * @param img_url the url of an image to share on Facebook
		 * 
		 **/
		function shareToFacebook(url:String = null, title:String = null, caption:String = null, description:String = null, img_url:String = null):void;
		
		/**
		 * Pops up the Twitter share dialog.  The Twitter share interaction is also tracked when 
		 * this is called.
		 *
		 * @param tweet the copy to share on Twitter
		 * @param url the url to share on Twitter
		 * 
		 **/
		function shareToTwitter(tweet:String = null, url:String = null):void;
		
		/**
		 * Pops up the Pinterest share dialog.  The Pinterest share interaction is also tracked when 
		 * this is called.
		 * 
		 * @param url the url to share on Pinterest
		 * @param description the copy to share on Pinterest
		 * @param img_url the url of the image to share on Pinterest
		 *
		 **/
		function shareToPinterest(url:String = null, description:String = null, img_url:String = null):void;
		
		
		/* =================================
		EXTERNAL API
		================================= */
		
		/**
		 * Opens an external browser window from the engagement.  The URL click interaction is also tracked when this is called.
		 *
		 * @param url the full URL path of the website.  If none is specified, uses the CLICK_TAG.
		 * @param type the type of window to open URL in. Possible values: 'popup', 'popunder', or 'tab'.  Default: 'popup'.
		 * @param width the width of the popup window, in pixels.  Default: 1024 pixels.
		 * @param height the height of the popup window, in pixels.  Default: 800 pixels.
		 * 
		 **/
		function popupWebsite(url:String = null, type:String = 'popup', width:Number = 1024, height:Number = 800):void;
		
		/**
		 * Initiates a file download.  The 'download' interaction is also tracked when this is called.
		 *
		 * @param url the full URL path of the file to download.
		 * @param filename the name of the file to download.
		 * 
		 **/
		function downloadFile(url:String, filename:String = 'download'):void;
		
		/**
		 * Initiates browser print of an image.  The 'print' interaction is also tracked when this is called.
		 *
		 * @param img_url the full URL path of an image to print.
		 * 
		 **/
		function printImg(img_url:String):void;
		
		/**
		 * Loads a given tracking image pixel URL.
		 * 
		 * @param pixel_url the full URL path to an image pixel.
		 * @param add_timestamp a flag indicating whether or not to add a cache-busting timestamp to the end of the URL.  The default is false.
		 *
		 **/
		function loadExternalPixel(pixel_url:String, add_timestamp:Boolean = false):void;
		
		/**
		 * Loads a given js script URL.
		 * 
		 * @param script_url the full js URL.
		 *
		 **/
		function loadExternalScript(script_url:String):void;

	}
}