class GiftOptionDecorator : Purchase {
    fileprivate let wrappedPurchase:Purchase;
    fileprivate let options:[OPTION];
    
    enum OPTION {
        case giftwrap;
        case ribbon;
        case delivery;
    }
    
    init(purchase:Purchase, options:OPTION...) {
        self.wrappedPurchase = purchase;
        self.options = options;
        super.init(product: purchase.description, price: purchase.totalPrice);
    }
    
    override var description:String {
        var result = wrappedPurchase.description;
        for option in options {
            switch (option) {
            case .giftwrap:
                result = "\(result) + giftwrap";
            case .ribbon:
                result = "\(result) + ribbon";
            case .delivery:
                result = "\(result) + delivery";
            }
        }
        return result;
    }
    
    override var totalPrice:Float {
        var result = wrappedPurchase.totalPrice;
        for option in options {
            switch (option) {
            case .giftwrap:
                result += 2;
            case .ribbon:
                result += 1;
            case .delivery:
                result += 5;
            }
        }
        return result;
    }
}

/*
class BasePurchaseDecorator : Purchase {
    private let wrappedPurchase:Purchase;

    init(purchase:Purchase) {
        wrappedPurchase = purchase;
        super.init(product: purchase.description, price: purchase.totalPrice);
    }
}

class PurchaseWithGiftWrap : BasePurchaseDecorator {
    override var description:String { return "\(super.description) + giftwrap"; }
    override var totalPrice:Float { return super.totalPrice + 2;}
}

class PurchaseWithRibbon : BasePurchaseDecorator {
    override var description:String { return "\(super.description) + ribbon"; }
    override var totalPrice:Float { return super.totalPrice + 1; }
}

class PurchaseWithDelivery : BasePurchaseDecorator {
    override var description:String { return "\(super.description) + delivery"; }
    override var totalPrice:Float { return super.totalPrice + 5; }
}

class PurchaseWithGiftWrapAndDelivery : Purchase {
    override var description:String {
    return "\(super.description) + giftwrap + delivery"; }
    override var totalPrice:Float { return super.totalPrice + 5 + 2; }
}
*/
