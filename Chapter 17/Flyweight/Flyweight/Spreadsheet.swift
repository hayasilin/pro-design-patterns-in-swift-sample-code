func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
    return lhs.col == rhs.col && lhs.row == rhs.row;
}

class Coordinate : Hashable, Printable {
    let col:Character;
    let row:Int;
    
    init(col:Character, row:Int) {
        self.col = col;
        self.row = row;
    }
    
    var hashValue: Int {
        return description.hashValue;
    }
    
    var description: String {
        return "\(col)(\row)";
    }
}

class Cell {
    var coordinate:Coordinate;
    var value:Int;
    
    init(col:Character, row:Int, val:Int) {
        self.coordinate = Coordinate(col: col, row: row);
        self.value = val;
    }
}

class Spreadsheet {
    //var grid = Dictionary<Coordinate, Cell>();
    var grid:Flyweight;
    
    init() {
        /*
        let letters:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        var stringIndex = letters.startIndex;
        let rows = 50;
        do {
            let colLetter = letters[stringIndex];
            stringIndex = stringIndex.successor();
            for rowIndex in 1 ... rows {
                let cell = Cell(col: colLetter, row: rowIndex, val: rowIndex);
                grid[cell.coordinate] = cell;
            }
        } while (stringIndex != letters.endIndex);
        */
        grid = FlyweightFactory.createFlyweight();
    }
    
    func setValue(coord: Coordinate, value:Int) {
        //grid[coord]?.value = value;
        grid[coord] = value;
    }
    
    var total:Int {
        //return reduce(grid.values, 0, { total, cell in return total + cell.value });
        return grid.total;
    }
}

