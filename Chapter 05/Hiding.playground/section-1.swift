import Foundation

class Message: NSObject, NSCopying {
    var to:String;
    var subject:String;
    
    init(to:String, subject:String) {
        self.to = to; self.subject = subject;
    }

    func copy(with zone: NSZone? = nil) -> Any {
        return Message(to:self.to, subject:self.subject);
    }
}

class DetailedMessage : Message {
    var from:String;
    
    init(to:String, subject:String, from:String) {
        self.from = from;
        super.init(to:to, subject:subject);
    }

    override func copy(with zone: NSZone?) -> Any {
        return DetailedMessage(to:self.to, subject:self.subject, from:self.from);
    }
}

class MessageLogger {
    var messages:[Message] = [];
    
    func logMessage(msg:Message) {
        messages.append(msg.copy() as! Message);
    }

    func processMessages(callback:(Message) -> Void) {
        for msg in messages {
            callback(msg);
        }
    }
}

var logger = MessageLogger();

var message = Message(to: "Joe", subject: "Hello");
logger.logMessage(msg: message);

message.to = "Bob";
message.subject = "Free for dinner?";
logger.logMessage(msg: message);

logger.logMessage(msg: DetailedMessage(to:"Alice", subject:"Hi!", from:"Joe"));


logger.processMessages(callback: {msg -> Void in

    if let detailed = msg as? DetailedMessage {
        print("Detailed Message - To: \(detailed.to) From: \(detailed.from)"
            + " Subject: \(detailed.subject)");
    } else {
        print("Message - To: \(msg.to) Subject: \(msg.subject)");
    }
});
