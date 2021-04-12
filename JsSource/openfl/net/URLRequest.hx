package openfl.net;

class URLRequest {
    
    public var url:String;

    public var method:String;

    public var data:Dynamic;

    public var requestHeaders:Array<URLRequestHeader> = [];

    public var contentType:Dynamic;

    public function new(url:String) {
        this.url = url;
    }

}