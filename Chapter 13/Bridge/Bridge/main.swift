//var clearChannel = Landline();
//var secureChannel = SecureLandLine();
//var comms = Communicator(clearChannel: clearChannel, secureChannel: secureChannel);

//var bridge = CommunicatorBridge(channel: SatelliteChannel());
//var bridge = CommunicatorBridge(channel: Channel.Channels.Satellite);
//var comms = Communicator(clearChannel: bridge, secureChannel: bridge, priorityChannel: bridge);
var comms = Communicator(channel: Channel.Channels.satellite);

comms.sendCleartextMessage("Hello!");
comms.sendSecureMessage("This is a secret");
comms.sendPriorityMessage("This is important");
