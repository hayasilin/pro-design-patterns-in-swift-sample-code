class PriceCalculator {
    class func calculatePrice(_ passengers:Int, days:Int) -> Float? {
    /*
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
    */
        var car = RentalCar.createRentalCar(passengers);
        return car == nil ? nil : car!.pricePerDay * Float(days);
    }
}
