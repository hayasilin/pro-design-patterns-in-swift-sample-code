class Purchase : CustomStringConvertible {
    fileprivate let product:String;
    fileprivate let price:Float;
    
    init(product:String, price:Float) {
        self.product = product;
        self.price = price;
    }
    
    var description:String {
        return product;
    }
    
    var totalPrice:Float {
        return price;
    }
}
