import Foundation;

class Pool<T:AnyObject> {
    fileprivate var data = [T]();
    fileprivate let arrayQ = DispatchQueue(label: "arrayQ", attributes: []);
    fileprivate let semaphore:DispatchSemaphore;
    
    //private var itemCount:Int = 0;
    fileprivate let maxItemCount:Int;
    fileprivate let itemFactory: () -> T;
    //private let peakFactory: () -> T;
    //private let peakReaper: (T) -> Void;
    fileprivate var createdCount:Int = 0;
    //private let normalCount:Int;
    //private let peakCount:Int;
    //private let returnCount:Int;
    //private let waitTime:Int;
    fileprivate let itemAllocator:([T]) -> Int;
    
    //private var ejectedItems = 0;
    //private var poolExhausted = false;
    
    //init(maxItemCount:Int, factory:() -> T) {
    //    self.itemFactory = factory;
    //    self.maxItemCount = maxItemCount;
    //    self.semaphore = dispatch_semaphore_create(maxItemCount);
    //}
    
    //init(itemCount:Int, peakCount:Int, returnCount:Int, waitTime:Int = 2, itemFactory:() -> T, peakFactory:() -> T, reaper:(T) -> Void) {
    init(itemCount:Int, itemFactory:@escaping () -> T, itemAllocator:@escaping (([T]) -> Int)) {
        self.maxItemCount = itemCount;
        //self.peakCount = peakCount;
        //self.waitTime = waitTime;
        //self.returnCount = returnCount;
        self.itemFactory = itemFactory;
        //self.peakFactory = peakFactory;
        //self.peakReaper = reaper;
        self.itemAllocator = itemAllocator;
        self.semaphore = DispatchSemaphore(value: itemCount);
    }
   
    func getFromPool() -> T? {
    //func getFromPool(maxWaitSeconds:Int = -1) -> T? {
        var result:T?;
        
        //let waitTime = (maxWaitSeconds == -1)
        //    ? DISPATCH_TIME_FOREVER
        //    : dispatch_time(DISPATCH_TIME_NOW, (Int64(maxWaitSeconds) * Int64(NSEC_PER_SEC)));
        //let expiryTime = dispatch_time(DISPATCH_TIME_NOW, (Int64(waitTime) * Int64(NSEC_PER_SEC)));
        
        /*
        if (!poolExhausted) {
            //if (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER) == 0) {
            if (dispatch_semaphore_wait(semaphore, waitTime) == 0) {
                if (!poolExhausted) {
                    dispatch_sync(arrayQ, {() in
                        if (self.data.count == 0 && self.itemCount < self.maxItemCount) {
                            result = self.itemFactory();
                            self.itemCount++;
                        } else {
                            result = self.data.removeAtIndex(0);
                        }
                    });
                }
            }
        }
        */
        /*
        if (dispatch_semaphore_wait(semaphore, expiryTime) == 0) {
            dispatch_sync(arrayQ, {() in
                if (self.data.count == 0) {
                    result = self.itemFactory();
                    self.createdCount++;
                } else {
                    result = self.data.removeAtIndex(0);
                }
            })
        } else {
            dispatch_sync(arrayQ, {() in
                result = self.peakFactory();
                self.createdCount++;
            });
        }
        */
        if (semaphore.wait(timeout: DispatchTime.distantFuture) == 0) {
            arrayQ.sync(execute: {() in
                if (self.data.count == 0) {
                    result = self.itemFactory();
                    self.createdCount += 1;
                } else {
                    result = self.data.remove(at: self.itemAllocator(self.data));
                }
            });
        }
        return result;
    }
    
    func returnToPool(_ item:T) {
        arrayQ.async(execute: {() in
            /*
            if let pitem = item as AnyObject as? PoolItem {
                if (pitem.canReuse) {
                //if (pitem == nil || pitem!.canReuse) {
                    self.data.append(item);
                    dispatch_semaphore_signal(self.semaphore);
                } else {
                    self.ejectedItems++;
                    if (self.ejectedItems == self.maxItemCount) {
                        self.poolExhausted = true;
                        self.flushQueue();
                    }
                }
            } else {
                self.data.append(item);
            }
            */
            //if (self.data.count > self.returnCount && self.createdCount > self.normalCount) {
            //    self.peakReaper(item);
            //    self.createdCount--;
            //} else {
                self.data.append(item);
                self.semaphore.signal();
            //}
        });
    }
/*
    private func flushQueue() {
        var dQueue = dispatch_queue_create("drainer", DISPATCH_QUEUE_CONCURRENT);
        var backlogCleared = false;
        dispatch_async(dQueue, {() in
            dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
            backlogCleared = true;
        });
        dispatch_async(dQueue, {() in
            while (!backlogCleared) {
                dispatch_semaphore_signal(self.semaphore);
            }
        });
    }
*/
    func processPoolItems(_ callback:([T]) -> Void) {
        arrayQ.sync(flags: .barrier, execute: {() in
            callback(self.data);
        });
    }
}
