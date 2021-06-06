class TreasureMap {
    
    enum Treasures {
        case galleon;
        case buried_GOLD;
        case sunken_JEWELS;
    }
    
    struct MapLocation {
        let gridLetter: Character;
        let gridNumber: UInt;
    }
    
    func findTreasure(_ type:Treasures) -> MapLocation {
        switch type {
            case .galleon:
                return MapLocation(gridLetter: "D", gridNumber: 6);
            case .buried_GOLD:
                return MapLocation(gridLetter: "C", gridNumber: 2);
            case .sunken_JEWELS:
                return MapLocation(gridLetter: "F", gridNumber: 12);
        }
    }
}
