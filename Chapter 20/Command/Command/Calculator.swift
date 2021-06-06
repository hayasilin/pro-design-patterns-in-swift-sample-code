import Foundation;

class Calculator {
    private(set) var total = 0;
    typealias CommandClosure = (Calculator -> Void);
    //private var history = [Command]();
    private var history = [CommandClosure]();
    private var queue = dispatch_queue_create("arrayQ", DISPATCH_QUEUE_SERIAL);
    //private var performingUndo = false;
    
    func add(amount:Int) {
        //addUndoCommand(Calculator.subtract, amount: amount);
        addMacro(Calculator.add, amount: amount);
        total += amount;
    }
    
    func subtract(amount:Int) {
        //addUndoCommand(Calculator.add, amount: amount);
        addMacro(Calculator.subtract, amount: amount);
        total -= amount;
    }
    
    func multiply(amount:Int) {
        //addUndoCommand(Calculator.divide, amount: amount);
        addMacro(Calculator.multiply, amount: amount);
        total = total * amount;
    }
    
    func divide(amount:Int) {
        //addUndoCommand(Calculator.multiply, amount: amount);
        addMacro(Calculator.divide, amount: amount);
        total = total / amount;
    }

    /*
    private func addUndoCommand(method:Calculator -> Int -> Void, amount:Int) {
        if (!performingUndo) {
            dispatch_sync(self.queue, {() in
                self.history.append(GenericCommand<Calculator>.createCommand(self, instuctions: { calc in
                    method(calc)(amount);
                }));
            });
        }
    }

    func undo() {
        //if self.history.count > 0 {
        //    self.history.removeLast().execute();
        //    self.history.removeLast();
        //}
        dispatch_sync(self.queue, {() in
            if self.history.count > 0 {
                self.performingUndo = true;
                self.history.removeLast().execute();
                self.performingUndo = false;
            }
        });
    }
    
    func getHistorySnaphot() -> Command? {
        var command:Command?;
        dispatch_sync(queue, {() in
            command = CommandWrapper(commands: self.history.reverse());
        });
        return command;
    }
    */

    private func addMacro(method:Calculator -> Int -> Void, amount:Int) {
        dispatch_sync(self.queue, {() in
            //self.history.append(GenericCommand<Calculator>.createCommand({
            //        calc in method(calc)(amount);
            //    }
            //));
            self.history.append({ calc in method(calc)(amount) });
        });
    }

    func getMacroCommand() -> (Calculator -> Void) {
    //func getMacroCommand() -> Command? {
        //var command:Command?;
        //dispatch_sync(queue, {() in
        //    command = CommandWrapper(commands: self.history);
        //});
        //return command;

        var commands = [CommandClosure]();
        dispatch_sync(queue, {() in
            commands = self.history;
        });
        
        return { calc in
            if (commands.count > 0) {
                for index in 0 ..< commands.count {
                    commands[index](calc.self);
                }
            }
        };
    }
}
