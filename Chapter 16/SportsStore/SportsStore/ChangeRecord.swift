class ChangeRecord : CustomStringConvertible {
    fileprivate let outerTag:String;
    fileprivate let productName:String;
    fileprivate let catName:String;
    fileprivate let innerTag:String;
    fileprivate let value:String;
    
    fileprivate init(outer:String, name:String, category:String, inner:String, value:String) {
        
        self.outerTag = outer;
        self.productName = name;
        self.catName = category;
        self.innerTag = inner;
        self.value = value;
    }
    
    var description : String {
        return "<\(outerTag)><\(innerTag) name=\"\(productName)\" category=\"\(catName)\">\(value)</\(innerTag)></\(outerTag)>"
    }
}

class ChangeRecordBuilder {
    var outerTag:String;
    var innerTag:String;
    var productName:String?;
    var category:String?;
    var value:String?;
    
    init() {
        outerTag = "change";
        innerTag = "product";
    }
    
    var changeRecord:ChangeRecord? {
        get {
            if (productName != nil && category != nil && value != nil) {
                return ChangeRecord(outer:outerTag, name:productName!, category:category!, inner:innerTag, value:value!);
            } else {
                return nil;
            }
        }
    }
}
