import Foundation;

//let logger = Logger();

var server = BackupServer.server;

//server.backup(DataItem(type: DataItem.ItemType.Email, data: "joe@example.com"));
//server.backup(DataItem(type: DataItem.ItemType.Phone, data: "555-123-1133"));
//globalLogger.log("Backed up 2 items to \(server.name)");
//var otherServer = BackupServer.server;

let queue = DispatchQueue(label: "workQueue", attributes: DispatchQueue.Attributes.concurrent);
let group = DispatchGroup();

for count in 0 ..< 100 {
    queue.async(group: group, execute: {() in
        server.backup(DataItem(type: DataItem.ItemType.Email, data: "bob@example.com"))
    });
}

group.wait(timeout: DispatchTime.distantFuture);

//globalLogger.log("Backed up 1 item to \(otherServer.name)");
//globalLogger.printLog();

print("\(server.getData().count) items were backed up");
