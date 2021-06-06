/*
enum ALGORITHM {
    case ADD;
    case MULTIPLY;
}
*/

final class Sequence {
    private var numbers:[Int];
    
    init(_ numbers:Int...) {
        self.numbers = numbers;
    }
    
    func addNumber(value:Int) {
        self.numbers.append(value);
    }
    
    func compute(strategy:Strategy) -> Int {
        return strategy.execute(self.numbers);
    }
    
    /*
    func compute(algorithm:ALGORITHM) -> Int {
        switch (algorithm) {
            case .ADD:
                return numbers.reduce(0, combine: { $0 + $1 });
            case .MULTIPLY:
                return numbers.reduce(1, combine: { $0 * $1 });
        }
    }

    func compute() -> Int {
        return numbers.reduce(0, combine: { $0 + $1 });
    }
    */
}