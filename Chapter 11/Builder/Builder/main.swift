//var builder = BurgerBuilder();

// Step 1 - Ask for name
let name = "Joe";

// Step 2 - Is veggie meal required?
//let veggie = false;

//builder.setVeggie(false);

// Step 2 - Select a Product
let builder = BurgerBuilder.getBuilder(Burgers.bigburger);

// Step 3 - Customize burger?
//let pickles = true;
//let mayo = false;
//let ketchup = true;
//let lettuce = true;
//let cooked = Burger.Cooked.NORMAL;

builder.setMayo(false);
builder.setCooked(Burger.Cooked.WELLDONE);

// Step 4 - Buy additional patty?
//let patties = 2;

//builder.addPatty(false);

//let order = Burger(name: "Joe", veggie: false, patties: 2, pickles: true, mayo: true, ketchup: true,
//    lettuce: true, cook: Burger.Cooked.NORMAL);
//let order = Burger(name: name, veggie: veggie, patties: patties, pickles: pickles, mayo: mayo,
//    ketchup: ketchup, lettuce: lettuce, cook: cooked);
let order = builder.buildObject(name);

order.printDescription();


var shake_one = Milkshake(
    flavor: Milkshake.Flavor.chocolate,
    size: Milkshake.Size.medium,
    count: 1
);
var shake_two = Milkshake(flavor: Milkshake.Flavor.chocolate);
