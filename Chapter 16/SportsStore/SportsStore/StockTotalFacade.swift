class StockTotalFacade {
    
    enum Currency {
        case usd;
        case gbp;
        case eur;
    }
    
    class func formatCurrencyAmount(_ amount:Double, currency:Currency) -> String? {
        var stfCurrency:StockTotalFactory.Currency;
        switch (currency) {
            case .eur:
                stfCurrency = StockTotalFactory.Currency.eur;
            case .gbp:
                stfCurrency = StockTotalFactory.Currency.gbp;
            case .usd:
                stfCurrency = StockTotalFactory.Currency.usd;
        }
        let factory = StockTotalFactory.getFactory(stfCurrency);
        let totalAmount = factory.converter?.convertTotal(amount);
        if (totalAmount != nil) {
            let formattedValue = factory.formatter?.formatTotal(totalAmount!);
            if (formattedValue != nil) {
                return formattedValue!;
            }
        }
        return nil;
    }
}
