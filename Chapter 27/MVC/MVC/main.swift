import Foundation;

let repository = MemoryRepository();
//let controllerChain = PersonController(repo:repository, nextController:nil);
let controllerChain = PersonController(repo:repository, nextController:CityController(repo:repository, nextController:nil));

var stdIn = NSFileHandle.fileHandleWithStandardInput();
var command = Command.LIST_PEOPLE;
var data = [String]();

while (true) {
    if let view = controllerChain.handleCommand(command, data:data) {
        view.execute();
        println("--Commands--");
        for command in Command.ALL {
            println(command.rawValue);
        }
    } else {
        fatalError("No view");
    }
    
    let input = NSString(data:stdIn.availableData, encoding:NSUTF8StringEncoding) ?? "";
    let scanner = NSScanner(string:input as! String).string;
    let inputArray:[String] = scanner.split();

    if (inputArray.count > 0) {
        command = Command.getFromInput(inputArray.first!) ?? Command.LIST_PEOPLE;
        if (inputArray.count > 1) {
            data = Array(inputArray[1...inputArray.count - 1]);
        } else {
            data = [];
        }
    }
    println("Command \(command.rawValue) Data \(data)");
}
