import Foundation;

class PirateCrew {
    let workQueue = DispatchQueue(label: "crewWorkQ", attributes: []);
    
    enum Actions {
        case attack_SHIP;
        case dig_FOR_GOLD;
        case dive_FOR_JEWELS;
    }
    
    func performAction(_ action:Actions, callback:@escaping (Int) -> Void) {
        workQueue.async(execute: {() in
            var prizeValue = 0;
            switch (action) {
                case .attack_SHIP:
                    prizeValue = 10000;
                case .dig_FOR_GOLD:
                    prizeValue = 5000;
                case .dive_FOR_JEWELS:
                    prizeValue = 1000;
            }
            callback(prizeValue);
        });
    }
}
