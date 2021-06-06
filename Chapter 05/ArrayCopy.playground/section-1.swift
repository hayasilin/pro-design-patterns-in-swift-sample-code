import Foundation

class Person: NSObject, NSCopying {
    var name:String;
    var country:String;
    
    init(name:String, country:String) {
        self.name = name; self.country = country;
    }

    func copy(with zone: NSZone? = nil) -> Any {
        return Person(name: self.name, country: self.country);
    }
}

func deepCopy(data:[AnyObject]) -> [AnyObject] {
    return data.map({item -> AnyObject in
        if (item is NSCopying && item is NSObject) {
            return (item as! NSObject).copy() as AnyObject;
        } else {
            return item;
        }
    })
}

var people = [Person(name:"Joe", country:"France"), Person(name:"Bob", country:"USA")];
var otherpeople = deepCopy(data: people) as! [Person];

people[0].country = "UK";
print("Country: \(otherpeople[0].country)");
