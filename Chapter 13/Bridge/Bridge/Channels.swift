/*
class Landline : ClearMessageChannel {
    func send(message: String) {
        println("Landline: \(message)");
    }
}

class SecureLandLine : SecureMessageChannel {
    func sendEncryptedMessage(message: String) {
        println("Secure Landline: \(message)");
    }
}

class Wireless : ClearMessageChannel {
    func send(message: String) {
        println("Wireless: \(message)");
    }
}

class SecureWireless : SecureMessageChannel {
    func sendEncryptedMessage(message: String) {
        println("Secure Wireless: \(message)");
    }
}
*/

/*
protocol Channel {
    func sendMessage(msg:Message);
}
*/

class Channel {
    
    enum Channels {
        case landline;
        case wireless;
        case satellite;
    }
    
    class func getChannel(_ channelType:Channels) -> Channel {
        switch channelType {
        case .landline:
            return LandlineChannel();
        case .wireless:
            return WirelessChannel();
        case .satellite:
            return SatelliteChannel();
        }
    }
    
    func sendMessage(_ msg:Message) {
        fatalError("Not implemented");
    }
}

class LandlineChannel : Channel {
    override func sendMessage(_ msg: Message) {
        print("Landline: \(msg.contentToSend)");
    }
    
}

class WirelessChannel : Channel {
    override func sendMessage(_ msg: Message) {
        print("Wireless: \(msg.contentToSend)");
    }
}
