package openfl.net;

import openfl.events.Event;
import openfl.events.IOErrorEvent;
import js.html.XMLHttpRequest;

class URLLoader {
	public var data:Dynamic;

	private var xml = new XMLHttpRequest();

	public function new() {}

	public function addEventListener(event:String, cb:Dynamic):Void {
		switch (event) {
			case Event.COMPLETE:
				xml.onloadend = function() {
					this.data = xml.responseText;
					cb(new Event());
				}
			case IOErrorEvent.IO_ERROR:
				xml.onerror = function() {
					this.data = xml.responseText;
					cb(new IOErrorEvent());
				}
		}
	}

	public function load(url:URLRequest):Void {
		xml.open(url.method, url.url);
		xml.send(url.data);
	}
}
