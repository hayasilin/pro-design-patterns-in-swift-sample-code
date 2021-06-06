import Foundation;
/*
let map = TreasureMap();
let ship = PirateShip();
let crew = PirateCrew();

let treasureLocation = map.findTreasure(TreasureMap.Treasures.GALLEON);

// convert from map to ship coordinates
let sequence:[Character] = ["A", "B", "C", "D", "E", "F", "G"];
let eastWestPos = find(sequence, treasureLocation.gridLetter);
let shipTarget = PirateShip.ShipLocation(NorthSouth: Int(treasureLocation.gridNumber), EastWest: eastWestPos!);

// relocate ship
ship.moveToLocation(shipTarget, callback: { location in
    // get the crew to work
    crew.performAction(PirateCrew.Actions.ATTACK_SHIP, callback: { prize in
        println("Prize: \(prize) pieces of eight");
    });
});
*/

let facade = PirateFacade();
let prize = facade.getTreasure(TreasureTypes.ship);

//if (prize != nil) {
//    println("Prize: \(prize!) pieces of eight");
//}

if (prize != nil) {
    facade.crew.performAction(PirateCrew.Actions.dive_FOR_JEWELS, callback: { secondPrize in
        print("Prize: \(prize! + secondPrize) pieces of eight");
    });
}

FileHandle.standardInput.availableData
