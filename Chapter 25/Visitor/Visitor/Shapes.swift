import Foundation;

class Circle : Shape {
    let radius:Float;
    
    init(radius:Float) {
        self.radius = radius;
    }
    
    func accept(visitor:Visitor) {
        visitor.visit(self);
    }
}

class Square : Shape {
    let length:Float;
    
    init(length:Float) {
        self.length = length;
    }
    
    func accept(visitor:Visitor) {
        visitor.visit(self);
    }
}

class Rectangle : Shape {
    let xLen:Float;
    let yLen:Float;
    
    init(x:Float, y:Float) {
        self.xLen = x;
        self.yLen = y;
    }
    
    func accept(visitor:Visitor) {
        visitor.visit(self);
    }
}

class ShapeCollection {
    //let shapes:[Any];
    let shapes:[Shape];
    
    init() {
        shapes = [
            Circle(radius: 2.5), Square(length: 4), Rectangle(x: 10, y: 2)
        ];
    }
    
    func accept(visitor:Visitor) {
        for shape in shapes {
            shape.accept(visitor);
        }
    }
    
    /*
    func calculateAreas() -> Float {
        return shapes.reduce(0, combine: { total, shape in
            if let circle = shape as? Circle {
                println("Found Circle");
                return total + (3.14 * powf(circle.radius, 2));
            } else if let square = shape as? Square {
                println("Found Square");
                return total + powf(square.length, 2);
            } else if let rect = shape as? Rectangle {
                println("Found Rectangle");
                return total + (rect.xLen * rect.yLen);
            } else {
                // unknown type - do nothing
                return total;
            }
        });
    }
    
    func countEdges() -> Int {
        return shapes.reduce(0, combine: { total, shape in
            if let circle = shape as? Circle {
                println("Found Circle");
                return total + 1;
            } else if let square = shape as? Square {
                println("Found Square");
                return total + 4;
            } else if let rect = shape as? Rectangle {
                println("Found Rectangle");
                return total + 4;
            } else {
                // unknown type - do nothing
                return total;
            }
        });
    }
    */
}