/*
func createRentalCar(passengers:Int) -> RentalCar? {
    var car:RentalCar?;
    switch (passengers) {
        case 0...1:
            car = Sports();
        case 2...3:
            car = Compact();
        case 4...8:
            car = SUV();
        case 9...14:
            car = Minivan();
        default:
            car = nil;
    }
    return car;
}

protocol RentalCar {
    var name:String { get };
    var passengers:Int { get };
    var pricePerDay:Float { get };
}
*/

class RentalCar {
    fileprivate var nameBV:String;
    fileprivate var passengersBV:Int;
    fileprivate var priceBV:Float;
    
    fileprivate init(name:String, passengers:Int, price:Float) {
        self.nameBV = name;
        self.passengersBV = passengers;
        self.priceBV = price;
    }

    final var name:String {
        get { return nameBV; }
    }
    
    final var passengers:Int {
        get { return passengersBV; }
    }
    
    final var pricePerDay:Float {
        get { return priceBV; }
    }
    
    class func createRentalCar(_ passengers:Int) -> RentalCar? {
        var carImpl:RentalCar.Type?;
        switch (passengers) {
        case 0...3:
            carImpl = Compact.self;
        case 4...8:
            carImpl = SUV.self;
        default:
            carImpl = nil;
        }
        return carImpl?.createRentalCar(passengers);
    }

}

class Compact : RentalCar {
    //var name = "VW Golf";
    //var passengers = 3;
    //var pricePerDay:Float = 20;
    fileprivate convenience init() {
        self.init(name: "VW Golf", passengers: 3, price: 20);
    }
    
    fileprivate override init(name:String, passengers:Int, price:Float) {
        super.init(name: name, passengers: passengers, price: price);
    }
    
    override class func createRentalCar(_ passengers:Int) -> RentalCar? {
        if (passengers < 2) {
            return sharedInstance;
        } else {
            return SmallCompact.sharedInstance;
        }
    }
    
    class var sharedInstance:RentalCar {
        get {
            struct SingletonWrapper {
                static let singleton = Compact();
            }
            return SingletonWrapper.singleton;
        }
    }
}

class SmallCompact : Compact {
    fileprivate init() {
        super.init(name: "Ford Fiesta", passengers: 3, price: 15);
    }
    
    override class var sharedInstance:RentalCar {
        get {
            struct SingletonWrapper {
                static let singleton = SmallCompact();
            }
            return SingletonWrapper.singleton;
        }
    }
}

class SUV : RentalCar {
    //var name = "Cadillac Escalade";
    //var passengers = 8;
    //var pricePerDay:Float = 75;
    fileprivate init() {
        super.init(name: "Cadillac Escalade", passengers: 8, price: 75);
    }
    
    override class func createRentalCar(_ passengers:Int) -> RentalCar? {
        return SUV();
    }
}

/*
class Sports : RentalCar {
    var name = "Porsche Boxter";
    var passengers = 1;
    var pricePerDay:Float = 100;
}

class Minivan : RentalCar {
    var name = "Chevrolet Express";
    var passengers = 14;
    var pricePerDay:Float = 40;
}
*/
