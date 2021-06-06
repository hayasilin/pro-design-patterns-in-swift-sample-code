enum Burgers {
    case standard;
    case bigburger;
    case superveggie;
}

class BurgerBuilder {
    fileprivate var veggie = false;
    fileprivate var pickles = false;
    fileprivate var mayo = true;
    fileprivate var ketchup = true;
    fileprivate var lettuce = true;
    fileprivate var cooked = Burger.Cooked.NORMAL;
    fileprivate var patties = 2;
    fileprivate var bacon = true;
    
    fileprivate init() {
        // do nothing
    }

    func setVeggie(_ choice: Bool) {
        self.veggie = choice;
        if (choice) {
            self.bacon = false;
        }
    }
    func setPickles(_ choice: Bool) { self.pickles = choice; }
    func setMayo(_ choice: Bool) { self.mayo = choice; }
    func setKetchup(_ choice: Bool) { self.ketchup = choice; }
    func setLettuce(_ choice: Bool) { self.lettuce = choice; }
    func setCooked(_ choice: Burger.Cooked) { self.cooked = choice; }
    func addPatty(_ choice: Bool) { self.patties = choice ? 3 : 2; }
    func setBacon(_ choice: Bool) { self.bacon = choice; }

    func buildObject(_ name: String) -> Burger {
        return Burger(name: name, veggie: veggie, patties: patties, pickles: pickles, mayo: mayo, ketchup: ketchup,
            lettuce: lettuce, cook: cooked, bacon: bacon);
    }
    
    class func getBuilder(_ burgerType:Burgers) -> BurgerBuilder {
        var builder:BurgerBuilder;
        switch (burgerType) {
            case .bigburger: builder = BigBurgerBuilder();
            case .superveggie: builder = SuperVeggieBurgerBuilder();
            case .standard: builder = BurgerBuilder();
        }
        return builder;
    }
}

class BigBurgerBuilder : BurgerBuilder {
    
    fileprivate override init() {
        super.init();
        self.patties = 4;
        self.bacon = false;
    }
    
    override func addPatty(_ choice: Bool) {
        fatalError("Cannot add patty to Big Burger");
    }
}

class SuperVeggieBurgerBuilder : BurgerBuilder {
    
    fileprivate override init() {
        super.init();
        self.veggie = true;
        self.bacon = false;
    }
    
    override func setVeggie(_ choice: Bool) {
        // do nothing - always veggie
    }
    
    override func setBacon(_ choice: Bool) {
        fatalError("Cannot add bacon to this burger");
    }
}
