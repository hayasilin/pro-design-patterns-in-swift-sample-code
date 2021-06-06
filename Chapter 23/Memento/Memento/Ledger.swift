import Foundation;

class LedgerEntry {
    let id:Int;
    let counterParty:String;
    let amount:Float;
    
    init(id:Int, counterParty:String, amount:Float) {
        self.id = id;
        self.counterParty = counterParty;
        self.amount = amount;
    }
}

class LedgerMemento : Memento {
    let data:NSData;

    init(data:NSData) {
        self.data = data;
    }
}

class Ledger : NSObject, Originator, NSCoding {
    private var entries = [Int:LedgerEntry]();
    private var nextId = 1;
    var total:Float = 0;
    
    override init() {
        // do nothing - required to allow instances
        // to be created without a coder
    }
    
    required init(coder aDecoder:NSCoder) {
        self.total = aDecoder.decodeFloatForKey("total");
        self.nextId = aDecoder.decodeIntegerForKey("nextId");
        self.entries.removeAll(keepCapacity:true);
        if let entryArray = aDecoder.decodeDataObject() as AnyObject? as? [NSDictionary] {
            for entryDict in entryArray {
                let id = entryDict["id"] as! Int;
                let counterParty = entryDict["counterParty"] as! String;
                let amount = entryDict["amount"] as! Float;
                self.entries[id] = LedgerEntry(id:id, counterParty:counterParty, amount:amount);
            }
        }
    }
    
    func encodeWithCoder(aCoder:NSCoder) {
        aCoder.encodeFloat(total, forKey:"total");
        aCoder.encodeInteger(nextId, forKey:"nextId");
        var entriesArray = [NSMutableDictionary]();
        for entry in self.entries.values {
            var dict = NSMutableDictionary();
            dict["id"] = entry.id;
            dict["counterParty"] = entry.counterParty;
            dict["amount"] = entry.amount;
            entriesArray.append(dict);
        }
        aCoder.encodeObject(entriesArray);
    }

    func addEntry(counterParty:String, amount:Float) {
        let entry = LedgerEntry(id:nextId++, counterParty:counterParty, amount:amount);
        entries[entry.id] = entry;
        total += amount;
    }
    
    func createMemento() -> Memento {
        return LedgerMemento(data:NSKeyedArchiver.archivedDataWithRootObject(self));
    }
    
    func applyMemento(memento:Memento) {
        if let m = memento as? LedgerMemento {
            if let obj = NSKeyedUnarchiver.unarchiveObjectWithData(m.data) as? Ledger {
                self.total = obj.total;
                self.nextId = obj.nextId;
                self.entries = obj.entries;
            }
        }
    }
    
    func printEntries() {
        for id in entries.keys.array.sorted(<) {
            if let entry = entries[id] {
                println("#\(id): \(entry.counterParty) $\(entry.amount)");
            }
        }
        println("Total: $\(total)");
        println("----");
    }
}

/*
class LedgerCommand {
    private let instructions:Ledger -> Void;
    private let receiver:Ledger;
        
    init(instructions:Ledger -> Void, receiver:Ledger) {
        self.instructions = instructions;
        self.receiver = receiver;
    }
        
    func execute() {
            self.instructions(self.receiver);
    }
}
*/
/*
class LedgerMemento : Memento {
    //private var entries = [LedgerEntry]();
    //private let total:Float;
    //private let nextId:Int;
    var jsonData:NSString?;
    
    init(ledger:Ledger) {
        //self.entries = ledger.entries.values.array;
        //self.total = ledger.total;
        //self.nextId = ledger.nextId;
        self.jsonData = stringify(ledger);
    }
    
    init(json:NSString?) {
        self.jsonData = json;
    }
    
    private func stringify(ledger:Ledger) -> NSString? {
        var dict = NSMutableDictionary();
        dict["total"] = ledger.total;
        dict["nextId"] = ledger.nextId;
        dict["entries"] = ledger.entries.values.array;
        var entryArray = [NSDictionary]();

        for entry in ledger.entries.values {
            var entryDict = NSMutableDictionary();
            entryArray.append(entryDict);
            entryDict["id"] = entry.id;
            entryDict["counterParty"] = entry.counterParty;
            entryDict["amount"] = entry.amount;
        }
        dict["entries"] = entryArray;
            
        if let json = NSJSONSerialization.dataWithJSONObject(dict, options:nil, error:nil) {
            return NSString(data:json, encoding:NSUTF8StringEncoding);
        }
        return nil;
    }

    func apply(ledger:Ledger) {
        /*
        ledger.total = self.total;
        ledger.nextId = self.nextId;
        ledger.entries.removeAll(keepCapacity:true);
        for entry in self.entries {
            ledger.entries[entry.id] = entry;
        }
        */
        if let data = jsonData?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion:false) {
            if let dict = NSJSONSerialization.JSONObjectWithData(data, options:nil, error:nil) as? NSDictionary {
                ledger.total = dict["total"] as! Float;
                ledger.nextId = dict["nextId"] as! Int;
                ledger.entries.removeAll(keepCapacity:true);
                if let entryDicts = dict["entries"] as? [NSDictionary] {
                    for dict in entryDicts {
                        let id = dict["id"] as! Int;
                        let counterParty = dict["counterParty"] as! String;
                        let amount = dict["amount"] as! Float;
                        ledger.entries[id] = LedgerEntry(id:id, counterParty:counterParty, amount:amount);
                    }
                }
            }
        }
    }
}

class Ledger : Originator {
    private var entries = [Int:LedgerEntry]();
    private var nextId = 1;
    var total:Float = 0;

    /*
    func addEntry(counterParty:String, amount:Float) -> LedgerCommand {
        let entry = LedgerEntry(id:nextId++, counterParty:counterParty, amount:amount);
        entries[entry.id] = entry;
        total += amount;
        return createUndoCommand(entry);
    }

    private func createUndoCommand(entry:LedgerEntry) -> LedgerCommand {
        return LedgerCommand(instructions: { target in
            let removed = target.entries.removeValueForKey(entry.id);
            if (removed != nil) {
                target.total -= removed!.amount;
            }
        }, receiver:self);
    }
    */
    
    func addEntry(counterParty:String, amount:Float) {
        let entry = LedgerEntry(id:nextId++, counterParty:counterParty, amount:amount);
        entries[entry.id] = entry;
        total += amount;
    }

    func createMemento() -> Memento {
        return LedgerMemento(ledger:self);
    }
    
    func applyMemento(memento:Memento) {
        if let m = memento as? LedgerMemento {
            m.apply(self);
        }
    }

    func printEntries() {
        for id in entries.keys.array.sorted(<) {
            if let entry = entries[id] {
                println("#\(id): \(entry.counterParty) $\(entry.amount)");
            }
        }
        println("Total: $\(total)");
        println("----");
    }
}
*/