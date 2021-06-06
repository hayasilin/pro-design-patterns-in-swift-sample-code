import Foundation;

//extension NewCoDirectory : EmployeeDataSource {
class NewCoDirectoryAdapter : EmployeeDataSource {
    fileprivate let directory:NewCoDirectory;

    init() {
        directory = NewCoDirectory();
    }

    var employees:[Employee] {
        return map(directory.getStaff().values, { sv -> Employee in
            return Employee(name: sv.getName(), title: sv.getJob());
        });
    }
    
    func searchByName(_ name:String) -> [Employee] {
        return createEmployees(filter: {(sv:NewCoStaffMember) -> Bool in
            return sv.getName().range(of: name) != nil;
        });
    }
    
    func searchByTitle(_ title:String) -> [Employee] {
        return createEmployees(filter: {(sv:NewCoStaffMember) -> Bool in
            return sv.getJob().range(of: title) != nil;
        });
    }
    
    fileprivate func createEmployees(filter filterClosure:((NewCoStaffMember) -> Bool)) -> [Employee] {
        return map(filter(directory.getStaff().values, filterClosure), {entry -> Employee in
            return Employee(name: entry.getName(), title: entry.getJob());
        });
    }
}
