class EventBridge {
    fileprivate let outputCallback:(String, Int) -> Void;
    
    init(callback:@escaping (String,Int) -> Void) {
        self.outputCallback = callback;
    }
    
    var inputCallback:(Product) -> Void {
        return { p in self.outputCallback(p.name, p.stockLevel); }
    }
}
