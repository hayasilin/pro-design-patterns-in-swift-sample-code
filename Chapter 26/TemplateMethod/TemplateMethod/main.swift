let donorDb = DonorDatabase();

//let galaInvitations = donorDb.generateGalaInvitations(2);
let galaInvitations = donorDb.generate(2);
for invite in galaInvitations {
    println(invite);
}

/*
donorDb.filter = { $0.filter({ $0.lastDonation == 0 } )};
donorDb.generate = { $0.map({ "Hi \($0.firstName)" }) };
let newDonors = donorDb.generate(Int.max);
for invite in newDonors {
    println(invite);
}
*/

class NewDonors : DonorDatabase {
    override func filter(donors: [Donor]) -> [Donor] {
        return donors.filter({ $0.lastDonation == 0 });
    }
    
    override func generate(donors: [Donor]) -> [String] {
        return donors.map({ "Hi \($0.firstName)" });
    }
}

let newDonor = NewDonors();
for invite in newDonor.generate(Int.max) {
    println(invite);
}
