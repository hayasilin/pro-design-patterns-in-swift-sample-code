import Foundation;

class Product : NSObject, NSCopying {
    
    fileprivate(set) var name:String;
    fileprivate(set) var productDescription:String;
    fileprivate(set) var category:String;
    fileprivate var stockLevelBackingValue:Int = 0;
    fileprivate var priceBackingValue:Double = 0;
    //private var salesTaxRate:Double = 0.2;
    
    required init(name:String, description:String, category:String, price:Double, stockLevel:Int) {
        self.name = name;
        self.productDescription = description;
        self.category = category;
        super.init();
        self.price = price;
        self.stockLevel = stockLevel;
    }
    
    var stockLevel:Int {
        get { return stockLevelBackingValue; }
        set { stockLevelBackingValue = max(0, newValue); }
    }
    
    fileprivate(set) var price:Double {
        get { return priceBackingValue; }
        set { priceBackingValue = max(1, newValue); }
    }
    
    var stockValue:Double {
        get {
            //return (price * (1 + salesTaxRate)) * Double(stockLevel);
            return price * Double(stockLevel);
        }
    }
    
    func copy(with zone:NSZone?) -> Any {
        return Product(name: self.name, description: self.description,
            category: self.category, price: self.price, stockLevel: self.stockLevel);
    }
    /*
    var upsells:[UpsellOpportunities] {
        get {
            return Array();
        }
    }
    */
    class func createProduct(_ name:String, description:String, category:String, price:Double, stockLevel:Int) -> Product {
        /*
        var productType:Product.Type;
        switch (category) {
        case "Watersports":
            productType = WatersportsProduct.self;
        case "Soccer":
            productType = SoccerProduct.self;
        default:
            productType = Product.self;
        }
        return productType(name:name, description: description, category: category, price: price, stockLevel: stockLevel);
        */
        return Product(name:name, description:description, category:category, price:price, stockLevel:stockLevel);
    }
}

class ProductComposite : Product {
    fileprivate let products:[Product];
    
    required init(name:String, description:String, category:String, price:Double, stockLevel:Int) {
        fatalError("Not implemented");
    }
    
    init(name:String, description:String, category:String, stockLevel:Int, products:Product...) {
        self.products = products;
        super.init(name:name, description:description, category:category, price:0, stockLevel:stockLevel);
    }
    
    override var price:Double {
        get { return reduce(products, 0, {total, p in return total + p.price}); }
        set { /* do nothing */ }
    }
}

/*
enum UpsellOpportunities {
    case SwimmingLessons;
    case MapOfLakes;
    case SoccerVideos;
}

class WatersportsProduct : Product {
    
    required init(name: String, description: String, category: String, price: Double, stockLevel: Int) {
        super.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel);
        salesTaxRate = 0.10;
    }
    
    override var upsells:[UpsellOpportunities] {
        return [UpsellOpportunities.SwimmingLessons, UpsellOpportunities.MapOfLakes];
    }
}

class SoccerProduct: Product {
    
    required init(name: String, description: String, category: String, price: Double, stockLevel: Int) {
        super.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel);
        salesTaxRate = 0.25;
    }
    
    override var upsells:[UpsellOpportunities] {
        return [UpsellOpportunities.SoccerVideos];
    }
}
*/
