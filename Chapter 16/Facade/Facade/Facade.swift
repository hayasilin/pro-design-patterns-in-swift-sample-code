import Foundation;

enum TreasureTypes {
    case ship;
    case buried;
    case sunken;
}

class PirateFacade {
    //private let map = TreasureMap();
    //private let ship = PirateShip();
    //private let crew = PirateCrew();
    let map = TreasureMap();
    let ship = PirateShip();
    let crew = PirateCrew();

    func getTreasure(_ type:TreasureTypes) -> Int? {
        
        var prizeAmount:Int?;
        
        // select the treasure type
        var treasureMapType:TreasureMap.Treasures;
        var crewWorkType:PirateCrew.Actions;
        switch (type) {
            case .ship:
                treasureMapType = TreasureMap.Treasures.galleon;
                crewWorkType = PirateCrew.Actions.attack_SHIP;
            case .buried:
                treasureMapType = TreasureMap.Treasures.buried_GOLD;
                crewWorkType = PirateCrew.Actions.dig_FOR_GOLD;
            case .sunken:
                treasureMapType = TreasureMap.Treasures.sunken_JEWELS;
                crewWorkType = PirateCrew.Actions.dive_FOR_JEWELS;
        }
        
        let treasureLocation = map.findTreasure(treasureMapType);

        // convert from map to ship coordinates
        let sequence:[Character] = ["A", "B", "C", "D", "E", "F", "G"];
        let eastWestPos = find(sequence, treasureLocation.gridLetter);
        let shipTarget = PirateShip.ShipLocation(NorthSouth: Int(treasureLocation.gridNumber), EastWest: eastWestPos!);
        
        let semaphore = DispatchSemaphore(value: 0);
        
        // relocate ship
        ship.moveToLocation(shipTarget, callback: { location in
            self.crew.performAction(crewWorkType, callback: { prize in
                prizeAmount = prize;
                semaphore.signal();
            });
        });
        
        semaphore.wait(timeout: DispatchTime.distantFuture);
        return prizeAmount;
    }
}
