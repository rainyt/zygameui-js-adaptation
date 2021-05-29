package openfl.net;

import sys.ssl.Socket;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
#if cpp
import haxe.Http;
#else
import js.html.XMLHttpRequest;
#end

class URLLoader {
	public var data:Dynamic;

	#if cpp
	private var xml:Http = null;
	#else
	private var xml = new XMLHttpRequest();
	#end

	public function new() {}

	#if cpp
	private dynamic function onloadend(e:Event) {}

	private dynamic function onerror(e:Event) {}
	#end

	public function addEventListener(event:String, cb:Dynamic):Void {
		#if cpp
		switch (event) {
			case Event.COMPLETE:
				this.onloadend = cb;
			case IOErrorEvent.IO_ERROR:
				this.onerror = cb;
		}
		#else
		switch (event) {
			case Event.COMPLETE:
				xml.onloadend = function() {
					this.data = xml.responseText;
					cb(new Event(Event.COMPLETE));
				}
			case IOErrorEvent.IO_ERROR:
				xml.onerror = function() {
					this.data = xml.responseText;
					cb(new IOErrorEvent(IOErrorEvent.IO_ERROR));
				}
		}
		#end
	}

	public function load(url:URLRequest):Void {
		#if cpp
		Socket.DEFAULT_VERIFY_CERT = false;
		xml = new Http(url.url);
		xml.onData = function(data) {
			this.data = data;
			onloadend(new Event(Event.COMPLETE));
		};
		xml.onError = function(data) {
			this.data = data;
			onerror(new IOErrorEvent(IOErrorEvent.IO_ERROR));
		}
		xml.setHeader("Content-Type", "application/json; charset=utf-8");
		xml.setPostData(url.data);
		xml.request(url.method == "POST");
		#else
		xml.open(url.method, url.url);
		xml.send(url.data);
		#end
	}
}
