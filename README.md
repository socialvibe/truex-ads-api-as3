TrueX Ads API for ActionScript 
==================================================

This project provides the necessary framework code for building an AS3 rich-media interative ad (engagement) for TrueX's ad container.

Getting Started
---------------
You can either include the API source code or the TrueX_ads_api.swc library file in your project.

Note: Our ad container uses the [GTween](http://www.gskinner.com/libraries/gtween/) tweening engine (also included as a SWC in the lib).  We choose GTween because its light weight and doesn’t conflict with greensock, which most developers use.  Feel free to use GTween or your own tween engine, such as greensock.

Import TrueX's API wrapper:
```as3
import com.truex.api.TxProxy;
```

Instantiate the API wrapper inside your main class by passing it a reference to your main class:
```as3
protected var _api:TxProxy = new TxProxy(this);
```

Ad Lifecycle
------------

##### Loading
Your ad will be dynamically loaded into the TrueX ad container through `flash.display.Loader`.  Therefore, you should not have any reference to `stage` in your constructor code since it will be `null` at construction time.

##### Start
When the TrueX engagement is ready to start, your ad will be added to stage and this method will be called on your ad:
```as3
// add this method to your main class
public function onEngagementStart():void {
	// Your ad should begin here.  Start intro animations, videos, etc.
}
```

##### End
Engagements end when users click "I'm Done" in the ad container header.  When this happens, the container calls:
```as3
// add this method to your main class
public function onEngagementEnd():void {
	// stop any running videos, sounds, etc.
}
```


Supporting In-player Rendering
------------------------------
TrueX engagements are often loaded within fullscreen video players.  In order to support video player controls, the following pause/resume/volume functionality should be implemented.

##### Pause
```as3
public function onEngagementPause():void {
	// pause running videos or sounds.
}
```
##### Resume
```as3
public function onEngagementResume():void {
	// resume previously running videos or sounds.
}
```

##### Volume Change
```as3
public function onEngagementVolumeChange(value:Number):void {
	// adjust volume on videos or sounds.  'value' will be a number between 0 and 1.

	// also note, the current volume level can be found at _api.getParams('player_volume');
}
```



API Usage
---------


#### Step Tracking
Each engagement is made up of multiple steps/frames.  Tracking the progress of the user through the various steps of the engagement is an important metric within TrueX.  Use these API calls to track the current step of the user.  The first step starts at 1.

When transitioning from one step to the next, make this call:
```as3
_api.incrementCurrentStep();
```

When transitioning to another step that isn't the next step in the ad flow, make this call:
```as3
_api.currentStep = 6;  // in this case the user is going to the 6th step
```


#### Video Tracking
Use the following API calls to track all videos within engagements.  We track video start, complete, replay, and each quartile.

```as3
_api.track.videoStarted(/* video label */);
_api.track.videoFirstQuartile(/* video label */);
_api.track.videoSecondQuartile(/* video label */);
_api.track.videoThirdQuartile(/* video label */);
_api.track.videoCompleted(/* video label */);
_api.track.videoReplay(/* video label */);
```


#### Game Play Tracking
Use the following API calls to track game play within engagements.  We track start, complete, and replay.  An optional `label` can be provided if there are multiple games.

```as3
_api.track.gameStarted(/* label */);
_api.track.gameCompleted(/* label */);
_api.track.gameReplay(/* label */);
```




#### Websites & Social Sharing
The following API calls should be used for clicking out to websites and sharing to social networks.

Opens an external browser window from the engagement.  In most cases each engagement has only one click out so no need to pass in a URL (its entered dynamically in our admin).  If a specific URL is specified, you can pass the URL as the first arugment.
```as3
_api.popupWebsite();

_api.popupWebsite(/* url */);
```

Share to Facebook:
```as3
_api.shareToFacebook(/* url */, /* title */, /* caption */, /* description */, /* image_url */);
```

Share to Twitter:
```as3
_api.shareToTwitter(/* tweet_text */, /* url */);
```

Share to Pinterest:
```as3
_api.shareToPinterest(/* url */, /* description */, /* image_url */);
```




#### User Data
TrueX has two forms of structured user data: Votes and Comments.  Votes are used to store poll and quiz answers.  Comments are used to store user comments.  Lastly, we have a few data entry API calls for storing email addresses, names, and zipcodes.

Saving vote data.  The first arugment is `category` a number representing the index of the question the user is answering (typically '1' for the first question, '2' for the second question).  The second arugment is `label` a string representation of the answer choice (typically the actual answer choice text).  The last arugment is `vote` a numerical representation of the answer choice.  This number must be unique across all answer choices and all question categories.
```as3
_api.saveVoteData(/* category */, /* label */, /* vote */);

// Example
_api.saveVoteData(1, 'Coca-cola', 11);
```

Retrieving vota data.  This method retrieves all vote data of users who have completed this engagement.
```as3
var votaData:Array = _api.getVoteSummary();

// returns an Array of vote data Objects, example:
// [ {category:"1", label:"Coca-cola", vote:"11", vote_count:"2023"}, ...]

```

Saving comment data:
```as3
_api.saveCommentData(/* comment */, /* label */);

// Example
_api.saveCommentData('I like diet coke!', 'fav_drink');
```

Retrieving comment data.  This method retrieves the last 5 comments made by users:
```as3
var commentData:Array = _api.getRecentComments();

// returns an Array of comment data Objects, example:
// [ {body:"I like diet coke!", ago:"31 minutes ago"}, ...]

```

Submitting email, name, and zipcode data:
```as3
_api.track.submitEmail(/* email */);

_api.track.submitName(/* name */);

_api.track.submitZipcode(/* zipcode */);

```


#### Utility Functions
The following API calls are provided as helper methods for some common functionality.  Each one handles the cooresponding interaction tracking call so no need to track separately.

Initiates a file download:
```as3
_api.downloadFile(/* url */, /* filename */);
```

Initiates browser to print an image:
```as3
_api.printImg(/* image_url */);
```


#### Misc Interaction Tracking
For all other interactions within engagements we track using a catch-all `other` tracking method.  Use this for tracking any *other* user interaction not covered by the above methods.

```as3
_api.track.other(/* name */, /* value */);

// Examples:
_api.track.other('choose_product', 'apple_flavor');
_api.track.other('score_submitted');
```





