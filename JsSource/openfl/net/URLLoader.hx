package openfl.net;

import sys.ssl.Socket;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
#if objc
import ios.foundation.NSURL;
import cpp.objc.NSError;
import ios.foundation.NSURLResponse;
import cpp.objc.NSData;
import Objc.NSData_NSURLResponse_NSError;
import ios.foundation.NSURLSession;
import ios.foundation.NSURLRequest;
#elseif sys
import haxe.Http;
#else
import js.html.XMLHttpRequest;
#end

class URLLoader {
	public var data:Dynamic;

	#if objc
	#elseif sys
	private var xml:Http = null;
	#else
	private var xml = new XMLHttpRequest();
	#end

	public function new() {}

	#if (sys || objc)
	private dynamic function onloadend(e:Event) {}

	private dynamic function onerror(e:Event) {}
	#end

	public function addEventListener(event:String, cb:Dynamic):Void {
		#if (sys || objc)
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
		#if objc
		var url = NSURL.URLWithString(url.url);
		var request = NSURLRequest.requestWithURL(url);
		var session = NSURLSession.sharedSession();
		var task = session.dataTaskWithRequestCompletionHandler(request,
			NSData_NSURLResponse_NSError(function(data:NSData, response:NSURLResponse, err:NSError) {
				if (err != null) {
					this.data = null;
					this.onerror(new IOErrorEvent(IOErrorEvent.IO_ERROR));
				} else {
					this.data = data.toBytes().toString();
					this.onloadend(new Event(Event.COMPLETE));
				}
			}));
		task.resume();
		#elseif sys
		Socket.DEFAULT_VERIFY_CERT = false;
		xml = new Http(url.url);
		#if curl
		var curl:String = "CURL: curl -H \"Content-Type:application/json\" -H \"showSignStr:true\" -X POST --data '" + url.data + "' " + url.url;
		trace(curl);
		#end
		xml.onData = function(data) {
			this.data = data;
			onloadend(new Event(Event.COMPLETE));
		};
		xml.onError = function(data) {
			this.data = data;
			onerror(new IOErrorEvent(IOErrorEvent.IO_ERROR));
		}
		xml.setHeader("Content-Type", "application/json");
		xml.setPostData(url.data);
		xml.request(url.method == "POST");
		#else
		xml.open(url.method, url.url);
		xml.send(url.data);
		#end
	}
}
