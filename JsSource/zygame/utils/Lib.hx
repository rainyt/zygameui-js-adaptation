package zygame.utils;

class Lib {
    
    public static function getData(key:String,defaultValue:Dynamic = null):Dynamic{
        return defaultValue;
    }

    public static function setData(key:String,value:Dynamic):Void{

    }

    public static function getChannel():String {
        return "cocos";
    }

    public static function getVersion():String {
        return "1000";
    }

    public static function setTimeout(cb:Dynamic,t:Int):Int{
        return -1;
    }

    public static function getUUID():String{
        return "####-####-####-###";
    }

}