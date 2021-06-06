let ledger = Ledger();

ledger.addEntry("Bob", amount: 100.43);
ledger.addEntry("Joe", amount: 200.20);

/*
let undoCommand = ledger.addEntry("Alice", amount: 500);
ledger.addEntry("Tony", amount: 20);
*/
/*
let aliceUndoCommand = ledger.addEntry("Alice", amount: 500);
let tonyUndoCommand = ledger.addEntry("Tony", amount: 20);
*/

let memento = ledger.createMemento();

/*
let memento = ledger.createMemento() as! LedgerMemento;
let newMemento = LedgerMemento(json:memento.jsonData);
ledger.applyMemento(newMemento);
*/
/*
ledger.addEntry("Alice", amount: 500);
ledger.addEntry("Tony", amount: 20);
*/

ledger.applyMemento(memento);

ledger.printEntries();

//undoCommand.execute();
//tonyUndoCommand.execute();
//aliceUndoCommand.execute();
//ledger.applyMemento(memento);
//ledger.printEntries();
