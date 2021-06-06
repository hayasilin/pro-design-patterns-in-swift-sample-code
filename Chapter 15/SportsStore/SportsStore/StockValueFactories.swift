import Foundation;

class StockTotalFactory {
    
    enum Currency {
        case usd
        case gbp
        case eur
    }
    
    fileprivate(set) var formatter:StockValueFormatter?;
    fileprivate(set) var converter:StockValueConverter?;
    
    class func getFactory(_ curr:Currency) -> StockTotalFactory {
        if (curr == Currency.usd) {
            return DollarStockTotalFactory.sharedInstance;
        } else if (curr == Currency.gbp) {
            return PoundStockTotalFactory.sharedInstance;
        } else {
            return EuroHandlerAdapter.sharedInstance;
        }
    }
}

private class DollarStockTotalFactory : StockTotalFactory {
    
    fileprivate override init() {
        super.init();
        formatter = DollarStockValueFormatter();
        converter = DollarStockValueConverter();
    }
    
    class var sharedInstance:StockTotalFactory {
        get {
            struct SingletonWrapper {
                static let singleton = DollarStockTotalFactory();
            }
            return SingletonWrapper.singleton;
        }
    }
}

private class PoundStockTotalFactory : StockTotalFactory {
    
    fileprivate override init() {
        super.init();
        formatter = PoundStockValueFormatter();
        converter = PoundStockValueConverter();
    }
    
    class var sharedInstance:StockTotalFactory {
        get {
            struct SingletonWrapper {
                static let singleton = PoundStockTotalFactory();
            }
            return SingletonWrapper.singleton;
        }
    }
}

class EuroHandlerAdapter : StockTotalFactory, StockValueConverter, StockValueFormatter {
    
    fileprivate let handler:EuroHandler;
    
    override init() {
        self.handler = EuroHandler();
        super.init();
        super.formatter = self;
        super.converter = self;
    }
    
    func formatTotal(_ total:Double) -> String {
        return handler.getDisplayString(total);
    }
    
    func convertTotal(_ total:Double) -> Double {
        return handler.getCurrencyAmount(total);
    }
    
    class var sharedInstance:EuroHandlerAdapter {
        get {
            struct SingletonWrapper {
                static let singleton = EuroHandlerAdapter();
            }
            return SingletonWrapper.singleton;
        }
    }
}
