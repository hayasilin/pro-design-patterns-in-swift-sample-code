class CarSelector {
    class func selectCar(_ passengers:Int) -> String? {
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
        return car?.name;
    */
        return RentalCar.createRentalCar(passengers)?.name;
    }
}
