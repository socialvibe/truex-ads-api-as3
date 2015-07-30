package com.truex.api
{
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.utils.Proxy;
	import flash.utils.describeType;
	import flash.utils.flash_proxy;
	
	dynamic public class TxProxy extends Proxy implements IEngagementAPI
	{
		static private var _apiInstance:*;

		private var _tracker:TxTracker;
		
		private var _currentStep:int;
		
		private var _preloadHandler:Function;
		private var _preloadCompletion:Function;
		private var _engagement:*;
		
		public function TxProxy(engagement:* = null) {
			if (_apiInstance == null) {
				_apiInstance = this;
				try {
					_apiInstance = ApplicationDomain.currentDomain.getDefinition('com.truex.api.TxAPI').getInstance();
				} catch (e:Error) { }
			}
			
			_tracker = new TxTracker(_apiInstance);
			
			if (engagement && engagement.stage != null && engagement.parent == engagement.stage) {
				_engagement = engagement;
				_engagement.addEventListener(Event.ACTIVATE, onLocalStart, false, 1000);
				_engagement.addEventListener(Event.ADDED_TO_STAGE, onLocalStart, false, 1000);
			} else if (engagement && engagement.stage == null) {
				_engagement = engagement;
				_engagement.addEventListener(Event.ADDED_TO_STAGE, onStart, false, 1000);
			}
		}
		
		static public function set engagementAPI(api:*):void
		{
			_apiInstance = api;
		}
			
		private function onLocalStart(e:Event):void
		{
			_engagement.removeEventListener(Event.ACTIVATE, onLocalStart);
			_engagement.removeEventListener(Event.ADDED_TO_STAGE, onLocalStart);
			
			_currentStep = 1;
			
			try {
				if (_engagement.hasOwnProperty('onComponentAdded')) {
					_engagement.addEventListener(Event.REMOVED_FROM_STAGE, function(e:Event):void {
						if (_engagement.hasOwnProperty('onComponentRemoved')) {
							_engagement.onComponentRemoved();
						}
					});
					_engagement.onComponentAdded();
				} else if (_engagement.hasOwnProperty('onEngagementStart')) {
					_engagement.onEngagementStart();
				}
			} catch (error:Error) { }
			
			if (preloadHandler != null) {
				_preloadCompletion = function():void {
					_engagement.dispatchEvent(new Event(Event.ADDED_TO_STAGE));
				};
				(preloadHandler as Function)();
			} else {
				_engagement.dispatchEvent(new Event(Event.ADDED_TO_STAGE));
			}
		}
		
		private function onStart(e:Event):void
		{
			_engagement.removeEventListener(Event.ADDED_TO_STAGE, onStart);
			
			try {
				if (_engagement.hasOwnProperty('onComponentAdded')) {
					_engagement.addEventListener(Event.REMOVED_FROM_STAGE, function(e:Event):void {
						if (_engagement.hasOwnProperty('onComponentRemoved')) {
							_engagement.onComponentRemoved();
						}
					});
					_engagement.onComponentAdded();
				} else if (_engagement.hasOwnProperty('onEngagementStart')) {
					_engagement.addEventListener(Event.REMOVED_FROM_STAGE, function(e:Event):void {
						if (_engagement.hasOwnProperty('onEngagementEnd')) {
							_engagement.onEngagementEnd();
						}
					});
					_engagement.onEngagementStart();
				}
			} catch (error:Error) {
				logError(error.message);
			}
		}
		
		public function get params():* { return (_apiInstance is TxProxy ? {} : _apiInstance.params); }
		public function get track():TxTracker { return _tracker; }
		
		public function set preloadHandler(handler:Function):void {
			if (_apiInstance is TxProxy)
				_preloadHandler = handler;
			else
				_apiInstance.preloadHandler = handler;
		}
		public function get preloadHandler():Function {	return (_apiInstance is TxProxy ? _preloadHandler : _apiInstance.preloadHandler); }
		
		public function get currentStep():int { return (_apiInstance is TxProxy ? _currentStep : _apiInstance.currentStep()); }
		public function set currentStep(index:int):void {
			if (_apiInstance is TxProxy)
				_currentStep = index;
			else
				_apiInstance.currentStep(index);
		}
		public function set totalStepCount(count:int):void {
			if (!(_apiInstance is TxProxy))
				_apiInstance.totalStepCount = count;
		}
		public function incrementCurrentStep():void {
			if (_apiInstance is TxProxy)
				_currentStep += 1;
			else
				_apiInstance.incrementCurrentStep();
		}

		public function getRecentComments():Array { return proxyCall(arguments.callee, arguments, this, []); }
		public function getVoteSummary():Array { return proxyCall(arguments.callee, arguments, this, []); }
		
		public function updatePreloadProgress(percent:Number):void { proxyCall(arguments.callee, arguments, this); }
		public function preloadCompleted():void { proxyCall(arguments.callee, arguments, this); if (_preloadCompletion != null) _preloadCompletion(); }
		public function endEngage():void { proxyCall(arguments.callee, arguments, this); }
		public function dispatchContainerEvent(event:String, data:Object = null):void { proxyCall(arguments.callee, arguments, this); }
		public function addContainerListener(event:String, callback:Function):void { proxyCall(arguments.callee, arguments, this); }
		public function removeContainerListener(event:String):void { proxyCall(arguments.callee, arguments, this); }
		public function trackInteraction(category:String, name:String, value:Object = null):void { proxyCall(arguments.callee, arguments, this); }
		public function saveCommentData(comment:String, label:String = null):void { proxyCall(arguments.callee, arguments, this); }
		public function saveVoteData(category:Number, label:String, vote:Number):void { proxyCall(arguments.callee, arguments, this); }
		public function shareToFacebook(url:String = null, title:String = null, caption:String = null, description:String = null, img_url:String = null):void { proxyCall(arguments.callee, arguments, this); }
		public function shareToTwitter(tweet:String = null, url:String = null):void { proxyCall(arguments.callee, arguments, this); }
		public function shareToPinterest(url:String = null, description:String = null, img_url:String = null):void { proxyCall(arguments.callee, arguments, this); }
		public function popupWebsite(url:String = null, type:String = 'popup', width:Number = 1024, height:Number = 800):void  { proxyCall(arguments.callee, arguments, this); }
		public function downloadFile(url:String, filename:String = 'download'):void { proxyCall(arguments.callee, arguments, this); }
		public function printImg(img_url:String):void { proxyCall(arguments.callee, arguments, this); }
		public function loadExternalPixel(pixel_url:String, add_timestamp:Boolean = false):void  { proxyCall(arguments.callee, arguments, this); }
		public function loadExternalScript(script_url:String):void { proxyCall(arguments.callee, arguments, this); }
		public function logError(msg:String):void { proxyCall(arguments.callee, arguments, this); }
		
		private function proxyCall(callee:Function, args:Array, parent:*, proxyResult:* = null):* {
			var methodName:String = '';
			for each ( var m:XML in describeType(parent)..method) {
				if ( parent[m.@name] == callee)	methodName = m.@name;
			}
			
			if (_apiInstance is TxProxy) {
				trace('TrueX API::' + methodName + "(" + args.join(', ') + ")");
			} else {
				return _apiInstance[methodName].apply(_apiInstance, args);
			}
			
			return proxyResult;
		}
		
		override flash_proxy function callProperty(methodName:*, ... args):* {
			try {
				if (_apiInstance is TxProxy) {
					trace('TrueX API::' + methodName + "(" + args.join(', ') + ")");
				} else {
					return _apiInstance[methodName].apply(_apiInstance, args);
				}
			} catch (e:Error) {
				trace ("TxProxy::" + e);
			}
			return {};
		}
	}
}