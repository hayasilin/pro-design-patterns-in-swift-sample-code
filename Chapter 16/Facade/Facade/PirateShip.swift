import Foundation;

class PirateShip {
    
    struct ShipLocation {
        let NorthSouth:Int;
        let EastWest:Int;
    }
    
    var currentPosition:ShipLocation;
    var movementQueue = DispatchQueue(label: "shipQ", attributes: []);
    
    init() {
        currentPosition = ShipLocation(NorthSouth: 5, EastWest: 5);
    }
    
    func moveToLocation(_ location:ShipLocation, callback:@escaping (ShipLocation) -> Void) {
        movementQueue.async(execute: { () in self.currentPosition = location;
            callback(self.currentPosition);
        });
    }
}
