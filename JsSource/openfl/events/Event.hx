package openfl.events;

class Event {
	public inline static var COMPLETE:String = "ok";

	public var type:String;

	public function new(type:String, bubbles:Bool = false, cancelable:Bool = false) {
		this.type = type;
	}
}
