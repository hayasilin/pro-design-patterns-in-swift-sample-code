var products = [
    Product(name: "Kayak", /* description: "A boat for one person", */ price: 275, stock: 10),
    Product(name: "Lifejacket", /* description: "Protective and fashionable", */ price: 48.95, stock: 14),
    Product(name: "Soccer Ball", /* description: "FIFA-approved size and weight", */ price: 19.5, stock: 32)
];

func calculateTax(_ product:Product) -> Double {
    return product.price * 0.2;
}

func calculateStockValue(_ productsArray:[Product]) -> Double {
    return productsArray.reduce(0, {(total, product) -> Double in
        //return total + (product.price * Double(product.stock))
        return total + product.stockValue;
    });
}

//println("Sales tax for Kayak: $\(calculateTax(products[0]))");
print("Sales tax for Kayak: $\(products[0].calculateTax(0.2))");
print("Total value of stock: $\(calculateStockValue(products))");
products[0].stock = -50;
print("Stock Level for Kayak: \(products[0].stock)");


//Wrong example
var badProducts = [
    ("Kayak", "A boat for one person", 275, 10),
    ("Lifejacket", "Protective and fashionable", 48.95, 14),
    ("Soccer Ball", "FIFA-approved size and weight", 19.5, 32)
]

func calculateTax(_ product: (String, String, Double, Int)) -> Double {
    return product.2 * 0.2;
}

func calculateStockValue(_ productsArray:[(String, String, Double, Int)]) -> Double {
    return productsArray.reduce(0, {(total, product) -> Double in
        return total + (product.2 * Double(product.3))
    });
}

print("Sales tax for Kayak: $\(calculateTax(products[0]))");
print("Total value of stock: $\(calculateStockValue(products))");

