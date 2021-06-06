import Foundation;

protocol HttpHeaderRequest {
    init(url:String);
    func getHeader(header:String, callback:(String, String?) -> Void);
    func execute();
}

class AccessControlProxy : HttpHeaderRequest {
    private let wrappedObject: HttpHeaderRequest;
    
    required init(url:String) {
        wrappedObject = HttpHeaderRequestProxy(url: url);
    }
    
    func getHeader(header: String, callback: (String, String?) -> Void) {
        wrappedObject.getHeader(header, callback: callback);
    }
    
    func execute() {
        if (UserAuthentication.sharedInstance.authenticated) {
            wrappedObject.execute();
        } else {
            fatalError("Unauthorized");
        }
    }
}

private class HttpHeaderRequestProxy : HttpHeaderRequest {
    /*
    private let queue = dispatch_queue_create("httpQ", DISPATCH_QUEUE_SERIAL);
    private let semaphore = dispatch_semaphore_create(0);
    private var cachedHeaders = [String:String]();
    
    func getHeader(url:String, header:String) -> String? {
        var headerValue:String?;

        dispatch_sync(self.queue, {() in
            if let cachedValue = self.cachedHeaders[header] {
                headerValue = "\(cachedValue) (cached)";
            } else {
                let nsUrl = NSURL(string: url);
                let request = NSURLRequest(URL: nsUrl!);
                NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { data, response, error in
                    if let httpResponse = response as? NSHTTPURLResponse {
                        let headers = httpResponse.allHeaderFields as! [String:String];
                        for (name, value) in headers {
                            self.cachedHeaders[name] = value;
                        }
                        headerValue = httpResponse.allHeaderFields[header] as? String;
                    }
                    dispatch_semaphore_signal(self.semaphore);
                }).resume();
                dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
            }
        });
        return headerValue;
    }
    */
    let url:String;
    var headersRequired:[String:(String, String?) -> Void];
    
    required init(url: String) {
        self.url = url;
         self.headersRequired = Dictionary<String, (String, String?) -> Void>();
    }
    
    func getHeader(header:String, callback:(String, String?) -> Void) {
        self.headersRequired[header] = callback;
    }
    
    func execute() {
        let nsUrl = NSURL(string: url);
        let request = NSURLRequest(URL: nsUrl!);
        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { data, response, error in
            if let httpResponse = response as? NSHTTPURLResponse {
                let headers = httpResponse.allHeaderFields as! [String:String];
                for (header, callback) in self.headersRequired {
                    callback(header, headers[header]);
                }
            }
        }).resume();
    }
}