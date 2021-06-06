protocol Command {
    func execute(receiver:Any);
}

class CommandWrapper : Command {
    private let commands:[Command];
    
    init(commands:[Command]) {
        self.commands = commands;
    }
    
    func execute(receiver:Any) {
        for command in commands {
            command.execute(receiver);
        }
    }
}

class GenericCommand<T> : Command {
    //private var receiver:T;
    private var instructions:T -> Void;
    
    //init(receiver:T, instructions:T -> Void) {
    //    self.receiver = receiver;
    //    self.instructions = instructions;
    //}
    
    init(instructions: T -> Void) {
        self.instructions = instructions;
    }
    
    //func execute() {
    //    instructions(receiver);
    //}
    
    func execute(receiver:Any) {
        if let safeReceiver = receiver as? T {
            instructions(safeReceiver);
        } else {
            fatalError("Receiver is not expected type");
        }
    }
    
    //class func createCommand(receiver:T, instuctions:T -> Void) -> Command {
    //    return GenericCommand(receiver: receiver, instructions: instuctions);
    //}
    
    class func createCommand(instuctions: T -> Void) -> Command {
        return GenericCommand(instructions: instuctions);
    }
}