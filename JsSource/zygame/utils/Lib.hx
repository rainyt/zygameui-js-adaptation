package zygame.utils;

#if objc
import ios.foundation.NSUserDefaults;
#end

class Lib {
	public static function getData(key:String, defaultValue:Dynamic = null):Dynamic {
		#if objc
		var value = NSUserDefaults.standardUserDefaults().stringForKey(key);
		return value == null ? defaultValue : value.toString();
		#else
		return defaultValue;
		#end
	}

	public static function setData(key:String, value:Dynamic):Void {
		#if objc
		NSUserDefaults.standardUserDefaults().setObjectForKey(value, key);
		#end
	}

	public static function getChannel():String {
		return "cocos";
	}

	public static function getVersion():String {
		return "1000";
	}

	public static function setTimeout(cb:Dynamic, t:Int):Int {
		return -1;
	}

	public static function getUUID():String {
		return "####-####-####-###";
	}
}
