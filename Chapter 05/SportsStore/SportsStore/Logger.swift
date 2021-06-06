import Foundation;

class Logger<T> where T:NSObject, T:NSCopying {
    var dataItems:[T] = [];
    var callback:(T) -> Void;

    init(callback:@escaping (T) -> Void) {
        self.callback = callback;
    }

    func logItem(_ item:T) {
        dataItems.append(item.copy() as! T);
        callback(item);
    }

    func processItems(_ callback:(T) -> Void) {
        for item in dataItems {
            callback(item);
        }
    }
}
