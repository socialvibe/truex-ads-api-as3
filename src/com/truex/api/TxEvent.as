package com.truex.api
{
	import flash.events.Event;

	public class TxEvent extends Event
	{
		public var data:Object;
		
		public function TxEvent(type:String,
								data:Object = null,
								bubbles:Boolean = false,
								cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
	}
}

