package com.truex.api
{
	public interface IEngagement
	{
		function onEngagementStart():void;
		function onEngagementEnd():void;
		
		function onEngagementPause():void;
		function onEngagementResume():void;
		function onEngagementVolumeChange(value:Number):void;
	}
}