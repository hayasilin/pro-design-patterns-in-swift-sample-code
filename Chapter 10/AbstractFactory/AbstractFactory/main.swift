/*
var car = Car(carType: Cars.SPORTS,
    floor: ShortFloorplan(),
    suspension: RaceSuspension(),
    drive: RearWheelDrive());
*/
/*
let factory = CarFactory.getFactory(Cars.SPORTS);

if (factory != nil) {
    let car = Car(carType: Cars.SPORTS,
        floor: factory!.createFloorplan(),
        suspension: factory!.createSuspension(),
        drive: factory!.createDrivetrain());

    car.printDetails();
}
*/
let car = Car(carType: Cars.SPORTS);
car.printDetails();
