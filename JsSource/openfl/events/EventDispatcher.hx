package openfl.events;

class EventDispatcher {
    
    public function new() {
        
    }

    public function addEventListener<T>(type:String, listener:T->Void, useCapture:Bool = false, priority:Int = 0, useWeakReference:Bool = false):Void {
		// if (__listener == null)
		// 	__listener = new EventDispatcher(this);
		// __listener.addEventListener(type, listener, useCapture, priority, useWeakReference);
	}

	public function removeEventListener<T>(type:String, listener:T->Void, useCapture:Bool = false):Void {
		// if (__listener != null)
		// 	__listener.removeEventListener(type, listener, useCapture);
	}

	public function dispatchEvent(event:Event):Bool {
		// if (__listener != null)
		// 	return __listener.dispatchEvent(event);
		return false;
	}

	public function hasEventListener(type:String):Bool {
		// if (__listener != null)
		// 	return __listener.hasEventListener(type);
		return false;
	}

	public function willTrigger(type:String):Bool {
		// if (__listener != null)
		// 	return __listener.willTrigger(type);
		return false;
	}

}