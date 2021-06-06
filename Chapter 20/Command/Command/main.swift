let calc = Calculator();
calc.add(10);
calc.multiply(4);
calc.subtract(2);

/*
println("Total: \(calc.total)");

for _ in 0 ..< 3 {
    calc.undo();
    println("Undo called. Total: \(calc.total)");
}

let snapshot = calc.getHistorySnaphot();
println("Pre-Snapshot Total: \(calc.total)");
snapshot?.execute();
println("Post-Snapshot Total: \(calc.total)");
*/

println("Calc 1 Total: \(calc.total)");

let macro = calc.getMacroCommand();

let calc2 = Calculator();
//macro?.execute(calc2);
macro(calc2);
println("Calc 2 Total: \(calc2.total)");
