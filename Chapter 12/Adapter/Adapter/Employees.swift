struct Employee {
    var name:String;
    var title:String;
}

protocol EmployeeDataSource {
    var employees:[Employee] { get };
    func searchByName(_ name:String) -> [Employee];
    func searchByTitle(_ title:String) -> [Employee];
}
