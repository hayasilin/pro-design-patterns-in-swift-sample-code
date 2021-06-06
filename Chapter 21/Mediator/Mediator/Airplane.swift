import Foundation;

struct Position {
    var distanceFromRunway:Int;
    var height:Int;
}

//func == (lhs:Airplane, rhs:Airplane) -> Bool {
//    return lhs.name == rhs.name;
//}

//class Airplane : Equatable {
//class Airplane : Peer {
//class Airplane : CommandPeer {
class Airplane : MessagePeer {
    var name:String;
    var currentPosition:Position;
    //private var otherPlanes:[Airplane];
    var mediator:MessageMediator;
    let queue = dispatch_queue_create("posQ", DISPATCH_QUEUE_CONCURRENT);

    init(name:String, initialPos:Position, mediator:MessageMediator) {
        self.name = name;
        self.currentPosition = initialPos;
        //self.otherPlanes = [Airplane]();
        self.mediator = mediator;
        mediator.registerPeer(self);
    }
    /*
    func addPlanesInArea(planes:Airplane...) {
        for plane in planes {
            otherPlanes.append(plane);
        }
    }

    func otherPlaneDidLand(plane:Airplane) {
        if let index = find(otherPlanes, plane) {
            otherPlanes.removeAtIndex(index);
        }
    }

    func otherPlaneDidChangePosition(plane:Airplane) -> Bool {
        return plane.currentPosition.distanceFromRunway ==
            self.currentPosition.distanceFromRunway &&
            abs(plane.currentPosition.height - self.currentPosition.height) < 1000;
    }
    
    func changePosition(newPosition:Position) {
        self.currentPosition = newPosition;
        for plane in otherPlanes {
            if (plane.otherPlaneDidChangePosition(self)) {
                println("\(name): Too close! Abort!");
                return;
            }
        }
        println("\(name): Position changed");
    }
    
    func land() {
        self.currentPosition = Position(distanceFromRunway: 0, height: 0);
        for plane in otherPlanes {
            plane.otherPlaneDidLand(self);
        }
        println("\(name): Landed");
    }
    */
    
    func handleMessage(messageType:String, data:Any?) -> Any? {
        var result:Any?;
        switch (messageType) {
            case "changePos":
                if let pos = data as? Position {
                    result = otherPlaneDidChangePosition(pos);
                }
            default:
                fatalError("Unknown message type");
        }
        return result;
    }
    
    func otherPlaneDidChangePosition(position:Position) -> Bool {
        var result = false;
        dispatch_sync(self.queue, {() in
            result = position.distanceFromRunway ==
                self.currentPosition.distanceFromRunway &&
                abs(position.height - self.currentPosition.height) < 1000;
        });
        return result;
    }

    func changePosition(newPosition:Position) {
        dispatch_barrier_sync(self.queue, {() in
            self.currentPosition = newPosition;
            /*
            if (self.mediator.changePosition(self, pos: self.currentPosition) == true) {
                println("\(self.name): Too close! Abort!");
                return;
            }
            */
            /*
            let c = Command(function: { peer in
                if let plane = peer as? Airplane {
                    return plane.otherPlaneDidChangePosition(self.currentPosition);
                } else {
                    fatalError("Type mismatch");
                }
            });
            let allResults = self.mediator.dispatchCommand(self, command: c);
            */
            let allResults = self.mediator.sendMessage(self, messageType:"changePos", data:newPosition);

            for result in allResults {
                if result as? Bool == true {
                    println("\(self.name): Too close! Abort!");
                    return;
                }
            }
            println("\(self.name): Position changed");
        });
    }

    func land() {
        dispatch_barrier_sync(self.queue, {() in
            self.currentPosition = Position(distanceFromRunway: 0, height: 0);
            self.mediator.unregisterPeer(self);
            println("\(self.name): Landed");
        });
    }
}
