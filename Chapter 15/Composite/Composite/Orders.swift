import Foundation;

class CustomerOrder {
    let customer:String;
    let parts:[CarPart];
    //let compositeParts:[CompositePart];
    
    //init(customer:String, parts:[Part], composites:[CompositePart]) {
    init(customer:String, parts:[CarPart]) {
        self.customer = customer;
        self.parts = parts;
        //self.compositeParts = composites;
    }
    
    var totalPrice:Float {
        //let partReducer = { (subtotal:Float, part:Part) -> Float in return subtotal + part.price };
        //var total = reduce(parts, 0, partReducer);
        //return reduce(compositeParts, total, { (subtotal, cpart) -> Float in return reduce(cpart.parts, subtotal, partReducer); });
        return reduce(parts, 0, { subtotal, part in return subtotal + part.price });
    }
    
    func printDetails() {
        print("Order for \(customer): Cost: \(formatCurrencyString(totalPrice))");
    }
    
    func formatCurrencyString(_ number:Float) -> String {
        let formatter = NumberFormatter();
        formatter.numberStyle = NumberFormatter.Style.currency;
        formatter.locale = Locale(identifier: "en_US");
        return formatter.string(from: NSNumber(value: number)) ?? "";
    }
}
