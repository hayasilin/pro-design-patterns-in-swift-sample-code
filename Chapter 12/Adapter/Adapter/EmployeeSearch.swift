class SearchTool {
    
    enum SearchType {
        case name;
        case title;
    }
    
    fileprivate let sources:[EmployeeDataSource];
    
    init(dataSources: EmployeeDataSource...) {
        self.sources = dataSources;
    }
    
    var employees:[Employee] {
        var results = [Employee]();
        for source in sources {
            results += source.employees;
        }
        return results;
    }
    
    
    func search(_ text:String, type:SearchType) -> [Employee] {
        var results = [Employee]();
        
        for source in sources {
            results += type == SearchType.name ? source.searchByName(text) : source.searchByTitle(text);
        }
        return results;
    }
}
