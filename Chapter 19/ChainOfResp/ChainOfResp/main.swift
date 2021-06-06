let messages = [
    Message(from: "bob@example.com", to: "joe@example.com", subject: "Free for lunch?"),
    Message(from: "joe@example.com", to: "alice@acme.com", subject: "New Contracts"),
    Message(from: "pete@example.com", to: "all@example.com", subject: "Priority: All-Hands Meeting"),
];

/*
let localT = LocalTransmitter();
let remoteT = RemoteTransmitter();
let priorityT = PriorityTransmitter();

for msg in messages {
    if (msg.subject.hasPrefix("Priority")) {
        priorityT.sendMessage(msg);
    } else if let index = find(msg.from, "@") {
        if (msg.to.hasSuffix(msg.from[Range<String.Index>(start: index, end: msg.from.endIndex)])) {
            localT.sendMessage(msg);
        } else {
            remoteT.sendMessage(msg);
        }
    } else {
        println("Error: cannot send message to \(msg.from)");
    }
}
*/

if let chain = Transmitter.createChain(true) {
    for msg in messages {
       let handled = chain.sendMessage(msg);
       println("Message sent: \(handled)");
    }
}