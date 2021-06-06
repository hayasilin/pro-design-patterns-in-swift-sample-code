/*
protocol ClearMessageChannel {
    func send(message:String);
}

protocol SecureMessageChannel {
    func sendEncryptedMessage(encryptedText:String);
}

protocol PriorityMessageChannel {
    func sendPriorityMessage(message:String);
}
*/

class Communicator {
    //private let clearChannel:ClearMessageChannel;
    //private let secureChannel:SecureMessageChannel;
    //private let priorityChannel:PriorityMessageChannel;
    fileprivate let channnel:Channel;

    /*
    init(clearChannel:ClearMessageChannel, secureChannel:SecureMessageChannel, priorityChannel:PriorityMessageChannel) {
        self.clearChannel = clearChannel;
        self.secureChannel = secureChannel;
        self.priorityChannel = priorityChannel;
    }
    */
    init(channel:Channel.Channels) {
        self.channnel = Channel.getChannel(channel);
    }

    fileprivate func sendMessage(_ msg:Message) {
        msg.prepareMessage();
        channnel.sendMessage(msg);
    }

    func sendCleartextMessage(_ message:String) {
        //self.clearChannel.send(message);
        self.sendMessage(ClearMessage(message: message));
    }

    func sendSecureMessage(_ message:String) {
        //self.secureChannel.sendEncryptedMessage(message);
        self.sendMessage(EncryptedMessage(message: message));
    }
    
    func sendPriorityMessage(_ message:String) {
        //self.priorityChannel.sendPriorityMessage(message);
        self.sendMessage(PriorityMessage(message: message));
    }
}
