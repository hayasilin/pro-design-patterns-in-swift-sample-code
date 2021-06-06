class EuroHandler {
    
    func getDisplayString(_ amount:Double) -> String {
        let formatted = Utils.currencyStringFromNumber(amount);
        return formatted
//        return "€\(dropFirst(formatted))";
    }
    
    func getCurrencyAmount(_ amount:Double) -> Double {
        return 0.76164 * amount;
    }
}
