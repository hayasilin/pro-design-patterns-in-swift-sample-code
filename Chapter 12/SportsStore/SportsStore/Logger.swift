import Foundation;

let productLogger = Logger<Product>(callback: {p in
    //println("Change: \(p.name) \(p.stockLevel) items in stock");
    
    var builder = ChangeRecordBuilder();
    builder.productName = p.name;
    builder.category = p.category;
    builder.value = String(p.stockLevel);
    builder.outerTag = "stockChange";
    
    var changeRecord = builder.changeRecord;
    if (changeRecord != nil) {
        print(builder.changeRecord!);
    }
});

final class Logger<T> where T:NSObject, T:NSCopying {
    var dataItems:[T] = [];
    var callback:(T) -> Void;
    var arrayQ = DispatchQueue(label: "arrayQ", attributes: DispatchQueue.Attributes.concurrent);
    var callbackQ = DispatchQueue(label: "callbackQ", attributes: []);

    fileprivate init(callback:@escaping (T) -> Void, protect:Bool = true) {
        self.callback = callback;
        if (protect) {
            self.callback = {(item:T) in
                self.callbackQ.sync(execute: {() in
                    callback(item);
                });
            };
        }
    }

    func logItem(_ item:T) {
        arrayQ.async(flags: .barrier, execute: {() in
            self.dataItems.append(item.copy() as! T);
            self.callback(item);
        });
    }

    func processItems(_ callback:(T) -> Void) {
        arrayQ.sync(execute: {() in
            for item in self.dataItems {
                callback(item);
            }
        });
    }
}
