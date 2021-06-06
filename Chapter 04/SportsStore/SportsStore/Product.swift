class Product {
    
    fileprivate(set) var name:String;
    fileprivate(set) var description:String;
    fileprivate(set) var category:String;
    fileprivate var stockLevelBackingValue:Int = 0;
    fileprivate var priceBackingValue:Double = 0;
    
    init(name:String, description:String, category:String, price:Double, stockLevel:Int) {
        self.name = name;
        self.description = description;
        self.category = category;
        self.price = price;
        self.stockLevel = stockLevel;
    }
    
    var stockLevel:Int {
        get {
            return stockLevelBackingValue;
        }
        set {
            stockLevelBackingValue = max(0, newValue);
        }
    }
    
    fileprivate(set) var price:Double {
        get { return priceBackingValue; }
        set { priceBackingValue = max(1, newValue); }
    }
    
    var stockValue:Double {
        get {
            return price * Double(stockLevel);
        }
    }
}
