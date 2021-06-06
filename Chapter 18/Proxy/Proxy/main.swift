import Foundation;
/*
func getHeader(header:String) {
    let url = NSURL(string: "http://www.apress.com");
    let request = NSURLRequest(URL: url!);
    NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { data, response, error in
        if let httpResponse = response as? NSHTTPURLResponse {
            if let headerValue = httpResponse.allHeaderFields[header] as? NSString {
                println("\(header): \(headerValue)");
            }
        }
    }).resume();
}
*/
let url = "http://www.apress.com";
let headers = ["Content-Length", "Content-Encoding"];
//let proxy = HttpHeaderRequestProxy(url: url);
let proxy = AccessControlProxy(url: url);


for header in headers {
    //getHeader(header);
    
    //if let val = proxy.getHeader(url, header:header) {
    //    println("\(header): \(val)");
    //}
    
    proxy.getHeader(header, callback: {header, val in
        if (val != nil) {
            println("\(header): \(val!)");
        }
    });
}

UserAuthentication.sharedInstance.authenticate("bob", pass: "secret");
proxy.execute();

NSFileHandle.fileHandleWithStandardInput().availableData;
