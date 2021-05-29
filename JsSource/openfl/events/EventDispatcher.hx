package openfl.events;

class EventDispatcher {
	public var eventsBinds:Map<String, Array<Dynamic->Void>> = [];

	public function new() {}

	public function addEventListener<T>(type:String, listener:T->Void, useCapture:Bool = false, priority:Int = 0, useWeakReference:Bool = false):Void {
		if (!eventsBinds.exists(type)) {
			eventsBinds.set(type, []);
		}
		eventsBinds.get(type).push(listener);
	}

	public function removeEventListener<T>(type:String, listener:T->Void, useCapture:Bool = false):Void {
		if (eventsBinds.exists(type)) {
			eventsBinds.get(type).remove(listener);
		}
	}

	public function dispatchEvent(event:Event):Bool {
		if (!eventsBinds.exists(event.type))
			return false;
		for (call in eventsBinds.get(event.type)) {
			call(event);
		}
		return false;
	}

	public function hasEventListener(type:String):Bool {
		if (eventsBinds.exists(type)) {
			return eventsBinds.get(type).length > 0;
		}
		return false;
	}

	public function willTrigger(type:String):Bool {
		return false;
	}
}
