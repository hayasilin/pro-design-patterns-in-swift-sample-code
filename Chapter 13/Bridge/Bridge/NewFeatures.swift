class SatelliteChannel : Channel {
    override func sendMessage(_ msg: Message) {
        print("Satellite: \(msg.contentToSend)");
    }
}

class PriorityMessage : ClearMessage {
    override var contentToSend:String {
        return "Important: \(super.contentToSend)";
    }
}
