class NewCoStaffMember {
    fileprivate var name:String;
    fileprivate var role:String;
    
    init(name:String, role:String) {
        self.name = name;
        self.role = role;
    }
    
    func getName() -> String {
        return name;
    }
    
    func getJob() -> String {
        return role;
    }
}

class NewCoDirectory {
    fileprivate var staff:[String: NewCoStaffMember];
    
    init() {
        staff = [
            "Hans": NewCoStaffMember(name: "Hans", role: "Corp Counsel"),
            "Greta": NewCoStaffMember(name: "Greta", role: "VP, Legal")
        ];
    }
    
    func getStaff() -> [String: NewCoStaffMember] {
        return staff;
    }
}
