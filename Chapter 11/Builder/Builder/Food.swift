class Burger {
    let customerName:String;
    let veggieProduct:Bool;
    let patties:Int;
    let pickles:Bool;
    let mayo:Bool;
    let ketchup:Bool;
    let lettuce:Bool;
    let cook:Cooked;
    let bacon:Bool;
    
    enum Cooked : String {
        case RARE = "Rare";
        case NORMAL = "Normal";
        case WELLDONE = "Well Done";
    }
    
    init(name:String, veggie:Bool, patties:Int, pickles:Bool, mayo:Bool, ketchup:Bool, lettuce:Bool, cook:Cooked, bacon:Bool) {
            
        self.customerName = name;
        self.veggieProduct = veggie;
        self.patties = patties;
        self.pickles = pickles;
        self.mayo = mayo;
        self.ketchup = ketchup;
        self.lettuce = lettuce;
        self.cook = cook;
        self.bacon = bacon;
    }
    
    func printDescription() {
        print("Name: \(self.customerName)");
        print("Veggie: \(self.veggieProduct)");
        print("Patties: \(self.patties)");
        print("Pickles: \(self.pickles)");
        print("Mayo: \(self.mayo)");
        print("Ketchup: \(self.ketchup)");
        print("Lettuce: \(self.lettuce)");
        print("Cook: \(self.cook.rawValue)");
        print("Bacon: \(self.bacon)");
    }
}

class Milkshake {
    enum Size { case small; case medium; case large };
    enum Flavor { case chocolate; case strawberry; case vanilla };
    
    let count:Int;
    let size:Size;
    let flavor:Flavor;
    
    init(flavor:Flavor, size:Size = Size.medium, count:Int = 1) {
        self.count = count;
        self.size = size;
        self.flavor = flavor;
    }
/*
    init(flavor:Flavor, size:Size, count:Int) {
        self.count = count;
        self.size = size;
        self.flavor = flavor;
    }
    
    convenience init(flavor:Flavor, size:Size) {
        self.init(flavor:flavor, size:size, count:1);
    }
    
    convenience init(flavor:Flavor) {
        self.init(flavor:flavor, size:Size.MEDIUM);
    }
*/
}


