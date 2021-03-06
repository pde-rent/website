#property copyright "Paul de Renty"
#property link      ""
#property version   "1.00"
#property strict

/*
PROTOTYPES:

001 = GetQuoteConcat(string separator, bool labelled);
002 = GetAccountInfoConcat(string separator, bool labelled);
003 = GetMarketInfoConcat(string symbol, string separator, bool labelled);

101 = GetAccountNumber();
102 = GetAccountName();
103 = GetAccountBrokerName();
104 = GetAccountServer();
105 = GetAccountCurrency();
106 = GetAccountCredit();
107 = GetAccountLeverage();
108 = GetAccountStopoutLvl();
109 = GetAccountStopoutMode();
110 = GetAccountMargin();
111 = GetAccountFreeMargin();
112 = GetAccountBalance();
113 = GetAccountEquity();
114 = GetAccountProfit();
115 = GetAccountRelativeDrawdawn();
116 = GetAccountAbsoluteDrawdawn();

201 = GetTradeAllowed(string symbol);
202 = GetLeverage(string symbol);
203 = GetRecquiredMargin(string symbol);
204 = GetLotSize(string symbol);
205 = GetMinLot(string symbol);
206 = GetMaxLot(string symbol);
208 = GetLotStep(string symbol);
209 = GetTickSize(string symbol);
210 = GetTickValue(string symbol);
211 = GetLotValue(string symbol);
212 = GetStopLevel(string symbol);
213 = GetFreezeLevel(string symbol);
214 = GetBid(string symbol);
215 = GetAsk(string symbol);
216 = GetSpread(string symbol);
217 = GetSwapLong(string symbol);
218 = GetSwapShort(string symbol);
219 = GetStarting(string symbol);
220 = GetExpiry(string symbol);
221 = GetStreak(int mode, string symbol, int magic_number, int order_type);
222 = GetWinRate(string symbol, int magic_number, int order_type);
223 = GetAbsoluteDrawdown(string symbol, int magic_number, int order_type);
224 = GetRelativeDrawdown(string symbol, int magic_number, int order_type);
225 = GetLossSum(int mode, string symbol, int magic_number, int order_type);
226 = GetProfitSum(int mode, string symbol, int magic_number, int order_type);
227 = GetPNL(int mode, string symbol, int magic_number, int order_type);
228 = GetOrderSum(int mode, string symbol, int magic_number, int order_type);
*/

string GetAccountProfit() {
    return (DoubleToStr(AccountProfit()));
}

string GetAccountBalance() {
    return (DoubleToStr(AccountBalance()));
}

string GetAccountEquity() {
    return (DoubleToStr(AccountEquity()));
}

string GetAccountLeverage() {
	return (IntegerToString(AccountLeverage()));
}

string GetAccountCredit() {
	return (DoubleToStr(AccountCredit()));
}

string GetAccountCurrency() {
	return (AccountCurrency());
}

string GetAccountFreeMargin() {
	return (DoubleToStr(AccountFreeMargin()));
}

string GetAccountMargin() {
	return (DoubleToStr(AccountMargin()));
}

string GetAccountName() {
	return (AccountName());
}

string GetAccountStopoutLvl() {
	return (IntegerToString(AccountStopoutLevel()));
}

string GetAccountStopoutMode() {
	return (IntegerToString(AccountStopoutMode()));
}

string GetAccountNumber() {
	return (IntegerToString(AccountNumber()));
}

string GetAccountBrokerName() {
	return (AccountCompany());
}

string GetAccountServer() {
	return (AccountServer());
}

string GetLotSize(string symbol) {
	return (DoubleToStr(MarketInfo(symbol, MODE_LOTSIZE)));
}

string GetTickSize(string symbol) {
    return (DoubleToStr(MarketInfo(symbol, MODE_TICKSIZE)));
}

string GetTickValue(string symbol) {
    return (DoubleToStr(MarketInfo(symbol, MODE_TICKVALUE)));
}

string GetRecquiredMargin(string symbol) {
    return (DoubleToStr(MarketInfo(symbol, MODE_MARGINREQUIRED)));
}

string GetLotValue(string symbol) {
    return (DoubleToStr(MarketInfo(symbol, MODE_BID) / MarketInfo(symbol, MODE_TICKSIZE)
    	* MarketInfo(symbol, MODE_TICKVALUE)));
}

string GetLeverage(string symbol) {
	double lot_value = MarketInfo(symbol, MODE_BID)
		/ MarketInfo(symbol, MODE_TICKSIZE) * MarketInfo(symbol, MODE_TICKVALUE);
    return (DoubleToStr(lot_value / MarketInfo(symbol, MODE_MARGINREQUIRED)));
}

string GetBid(string symbol) {
    return (DoubleToStr(MarketInfo(symbol, MODE_BID)));
}

string GetAsk(string symbol) {
    return (DoubleToStr(MarketInfo(symbol, MODE_ASK)));
}

string GetSpread(string symbol) {
    return (DoubleToStr(MarketInfo(symbol, MODE_SPREAD)));
}

string GetStopLevel(string symbol) {
    return (DoubleToStr(MarketInfo(symbol, MODE_STOPLEVEL)));
}

string GetFreezeLevel(string symbol) {
    return (DoubleToStr(MarketInfo(symbol, MODE_FREEZELEVEL)));
}

string GetSwapLong(string symbol) {
    return (DoubleToStr(MarketInfo(symbol, MODE_SWAPLONG)));
}

string GetSwapShort(string symbol) {
    return (DoubleToStr(MarketInfo(symbol, MODE_SWAPSHORT)));    
}

string GetStarting(string symbol) {
    return (DoubleToStr(MarketInfo(symbol, MODE_STARTING)));
}

string GetExpiry(string symbol) {
    return (DoubleToStr(MarketInfo(symbol, MODE_EXPIRATION)));
}

string GetTradeAllowed(string symbol) {
    return (DoubleToStr(MarketInfo(symbol, MODE_TRADEALLOWED)));    
}

string GetMinLot(string symbol) {
    return (DoubleToStr(MarketInfo(symbol, MODE_MINLOT)));
}

string GetMaxLot(string symbol) {
    return (DoubleToStr(MarketInfo(symbol, MODE_MAXLOT)));
}

string GetLotStep(string symbol) {
    return (DoubleToStr(MarketInfo(symbol, MODE_LOTSTEP)));
}

int GetQuoteArray(string &pairs[]) {
    string     symbol;
    string     firstChar;
    bool       selected = false;
    int        i = 0;
    const int  symbolsCount = SymbolsTotal(selected);

    ArrayResize(pairs, symbolsCount);
    for(int idxSymbol = 0; idxSymbol < symbolsCount; idxSymbol++) {   
        symbol = SymbolName(idxSymbol, selected);
        firstChar = StringSubstr(symbol, 0, 1);
        if(firstChar != "#")//&& StringLen(symbol) == 6)
            pairs[i++] = symbol; 
    }
    ArrayResize(pairs, i);
    return i;
}

string GetQuoteConcat(string separator, bool labelled) {
    string     pairs[];
    string     concat = "";
    int        len = GetQuoteArray(pairs);

    for(int i = 0; i < len; i++) {
    	if (labelled) concat += ("#" + IntegerToString(i) + ": ");
    	concat += (pairs[i] + separator);
    }
    return(concat);
}

string GetAccountInfoConcat(string separator, bool labelled) {
	string concat;

	if (labelled) {
		concat = "Account Context:" + separator
	    + ("Number:      " + GetAccountNumber() + separator)
	    + ("Name:        " + GetAccountName() + separator)
	    + ("Broker:      " + GetAccountBrokerName() + separator)
	    + ("Server:      " + GetAccountServer() + separator)
	    + ("Leverage:    " + GetAccountLeverage() + separator)
		+ ("Stopout:     " + GetAccountStopoutLvl() + separator);
	}
	else {
		concat = "Account Context:" + separator
	    + (GetAccountNumber() + separator)
	    + (GetAccountName() + separator)
	    + (GetAccountBrokerName() + separator)
	    + (GetAccountServer() + separator)
	    + (GetAccountLeverage() + separator)
		+ (GetAccountStopoutLvl() + separator);
	}
    return (concat);
}

string GetMarketInfoConcat(string symbol, string separator, bool labelled) {
	string concat;

	if (labelled) {
		concat = symbol + " Market Context:" + separator
		+ ("Allowance:   " + GetTradeAllowed(symbol) + separator)
	    + ("Leverage:    " + GetLeverage(symbol) + separator)
	    + ("Tick Size:   " + GetTickSize(symbol) + separator)
	    + ("Tick Value:  " + GetTickValue(symbol) + separator)
	    + ("Lot Size:    " + GetLotSize(symbol) + separator)
	    + ("Lot Value:   " + GetLotValue(symbol) + separator)
		+ ("Min Lot:     " + GetMinLot(symbol) + separator)
	    + ("Max Lot:     " + GetMaxLot(symbol) + separator)
	    + ("Lot Step:    " + GetLotStep(symbol) + separator)
	    + ("Freeze lvl:  " + GetFreezeLevel(symbol) + separator)
	    + ("Stop lvl:    " + GetStopLevel(symbol) + separator);
	}
	else {
		concat = symbol + " Market Context:" + separator
		+ (GetTradeAllowed(symbol) + separator)
	    + (GetLeverage(symbol) + separator)
	    + (GetTickSize(symbol) + separator)
	    + (GetTickValue(symbol) + separator)
	    + (GetLotSize(symbol) + separator)
	    + (GetLotValue(symbol) + separator)
		+ (GetMinLot(symbol) + separator)
	    + (GetMaxLot(symbol) + separator)
	    + (GetLotStep(symbol) + separator)
	    + (GetFreezeLevel(symbol) + separator)
	    + (GetStopLevel(symbol) + separator);
	}
    return (concat);
}

// mode = 1: win streak, mode = 2: loss streak
string GetStreak(int mode, string symbol, int magic_number, int order_type) {
    int count = 0;

    for (int i = 0; i < OrdersHistoryTotal(); i++) {
        if (!OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) { continue; }
        if ((OrderMagicNumber() == magic_number || magic_number == 0)
        && (OrderSymbol() == symbol || symbol == "all")
        && (OrderType() == order_type || order_type == 6))
            if ((mode == 1 && (OrderProfit() + OrderCommission() + OrderSwap()) > 0) //chain win
            || (mode == 2 && (OrderProfit() + OrderCommission() + OrderSwap()) <= 0)) //chain loss
                ++count;
            else
                return (IntegerToString(count));
    }
    return (IntegerToString(count));
}

string GetWinRate(string symbol, int magic_number, int order_type) {
    int profits = 0;
    int loss = 0;

    for (int i = 0; i < OrdersHistoryTotal(); i++) {
        if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) { continue; }
        if ((OrderMagicNumber() == magic_number || magic_number == 0)
        && (OrderSymbol() == symbol || symbol == "all")
        && (OrderType() == order_type || order_type == 6))
            if ((OrderProfit() + OrderCommission() + OrderSwap()) > 0)
                ++profits;
            else
                ++loss;
    }
    return (DoubleToStr((double)profits / (double)loss));
}

string GetAbsoluteDrawdown(string symbol, int magic_number, int order_type) {
    double dd = 0;

    for (int i = 0; i < OrdersHistoryTotal(); i++) {
        if (!OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) { continue; }
        if ((OrderMagicNumber() == magic_number || magic_number == 0)
        && (OrderSymbol() == symbol || symbol == "all")
        && (OrderType() == order_type || order_type == 6))
        dd += (OrderProfit() + OrderCommission() + OrderSwap());
    }
    return (DoubleToStr(dd));
}

string GetRelativeDrawdown(string symbol, int magic_number, int order_type) {
    double dd = 0;

    for (int i = 0; i < OrdersHistoryTotal(); i++) {
        if (!OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) { continue; }
        if ((OrderMagicNumber() == magic_number || magic_number == 0)
        && (OrderSymbol() == symbol || symbol == "all")
        && (OrderType() == order_type || order_type == 6))
        dd += (OrderProfit() + OrderCommission() + OrderSwap());
    }
    return (DoubleToStr(dd / AccountBalance()));
}

string GetAccountAbsoluteDrawdawn() {
    double equity = AccountEquity();
    double balance = AccountBalance();
    double dd = 0;

    dd = equity - balance;
    return (DoubleToStr(dd));
}

string GetAccountRelativeDrawdawn() {
    double equity = AccountEquity();
    double balance = AccountBalance();
    double dd = 0;

    dd = equity - balance;
    return (DoubleToStr(dd / AccountBalance()));
}

// mode == OP_, mode = 6: all orders selected
string GetLossSum(int mode, string symbol, int magic_number, int order_type){
    double loss = 0;

    for (int i = 0; i < OrdersHistoryTotal(); i++) {
        if (!OrderSelect(i, SELECT_BY_POS, mode)) { continue; }
        if ((OrderMagicNumber() == magic_number || magic_number == 0)
        && (OrderSymbol() == symbol || symbol == "all")
        && (OrderType() == order_type || order_type == 6)
        && OrderProfit() <= 0) {
            loss += (OrderProfit() + OrderCommission() + OrderSwap());
        }
    }
    return (DoubleToStr(loss));
}

// mode == OP_, mode = 6: all orders selected
string GetProfitSum(int mode, string symbol, int magic_number, int order_type){
    double profit = 0;

    for (int i = 0; i < OrdersHistoryTotal(); i++) {
        if (!OrderSelect(i, SELECT_BY_POS, mode)) { continue; }
        if ((OrderMagicNumber() == magic_number || magic_number == 0)
        && (OrderSymbol() == symbol || symbol == "all")
        && (OrderType() == order_type || order_type == 6)
        && OrderProfit() > 0) {
            profit += (OrderProfit() + OrderCommission() + OrderSwap());
        }
    }
    return (DoubleToStr(profit));
}

// mode == OP_, mode = 6: all orders selected
string GetPNL(int mode, string symbol, int magic_number, int order_type){
    double profit = 0;

    for (int i = 0; i < OrdersHistoryTotal(); i++) {
        if (!OrderSelect(i, SELECT_BY_POS, mode)) { continue; }
        if ((OrderMagicNumber() == magic_number || magic_number == 0)
        && (OrderSymbol() == symbol || symbol == "all")
        && (OrderType() == order_type || order_type == 6)) {
            profit += (OrderProfit() + OrderCommission() + OrderSwap());
        }
    }
    return (DoubleToStr(profit));
}

// mode == OP_, mode = 6: all orders selected
string GetOrderSum(int mode, string symbol, int magic_number, int order_type/*, int order_profit*/) {
    int sum = 0;
    
    for (int i = 0; i < OrdersTotal(); i++) {
        if (!OrderSelect(i, SELECT_BY_POS, mode)) { continue; }
        if ((OrderMagicNumber() == magic_number || magic_number == 0)
        && (OrderSymbol() == symbol || symbol == "all")
        && (OrderType() == order_type || order_type == 6))
        // && (OrderProfit() > 0 && order_profit == 1))
            sum++;
    }
    return (DoubleToStr(sum));
}
/*
OP_ =BUY 0           //Buy 
OP_ =SELL 1          //Sell 
OP_ =BUYLIMIT 2      //Pending order of BUY LIMIT type 
OP_ =SELLLIMIT 3     //Pending order of SELL LIMIT type 
OP_ =BUYSTOP 4       //Pending order of BUY STOP type 
OP_ =SELLSTOP 5      //Pending order of SELL STOP type 
//---
MOD =E_OPEN 0
MOD =E_CLOSE 3
MOD =E_VOLUME 4 
MOD =E_REAL_VOLUME 5
MOD =E_TRADES 0
MOD =E_HISTORY 1
SEL =ECT_BY_POS 0
SEL =ECT_BY_TICKET 1
//---
DOU =BLE_VALUE 0
FLO =AT_VALUE 1
LON =G_VALUE INT_VALUE
//---
CHA =RT_BAR 0
CHA =RT_CANDLE 1
//---
MOD =E_ASCEND 0
MOD =E_DESCEND 1
//---
MOD =E_LOW 1
MOD =E_HIGH 2
MOD =E_TIME 5
MOD =E_BID 9
MOD =E_ASK 10
MOD =E_POINT 11
MOD =E_DIGITS 12
MOD =E_SPREAD 13
MOD =E_STOPLEVEL 14
MOD =E_LOTSIZE 15
MOD =E_TICKVALUE 16
MOD =E_TICKSIZE 17
MOD =E_SWAPLONG 18
MOD =E_SWAPSHORT 19
MOD =E_STARTING 20
MOD =E_EXPIRATION 21
MOD =E_TRADEALLOWED 22
MOD =E_MINLOT 23
MOD =E_LOTSTEP 24
MOD =E_MAXLOT 25
MOD =E_SWAPTYPE 26
MOD =E_PROFITCALCMODE 27
MOD =E_MARGINCALCMODE 28
MOD =E_MARGININIT 29
MOD =E_MARGINMAINTENANCE 30
MOD =E_MARGINHEDGED 31
MOD =E_MARGINREQUIRED 32
MOD =E_FREEZELEVEL 33
//---
EMP =TY -1
//---
Currency Code   Currency Name   Symbol  Unicode (Hex)
AED United Arab Emirates Dirham د.إ 62f, 2e, 625
ANG NL Antillian Guilder    ƒ   192
ARS Argentine Peso  $   24
AUD Australian Dollar   A$  41, 24
BRL Brazilian Real  R$  52, 24
BSD Bahamian Dollar B$  42, 24
CAD Canadian Dollar $   24
CHF Swiss Franc CHF 43, 48, 46
CLP Chilean Peso    $   24
CNY Chinese Yuan Renminbi   ¥   a5
COP Colombian Peso  $   24
CZK Czech Koruna    Kč  4b,10d
DKK Danish Krone    kr  6b, 72
EUR Euro    €   20ac
FJD Fiji Dollar FJ$ 46, 4a, 24
GBP British Pound   £   a3
GHS Ghanaian New Cedi   GH₵ 47, 48, 20b5
GTQ Guatemalan Quetzal  Q   51
HKD Hong Kong Dollar    $   24
HNL Honduran Lempira    L   4c
HRK Croatian Kuna   kn  6b, 6e
HUF Hungarian Forint    Ft  46, 74
IDR Indonesian Rupiah   Rp  52, 70
ILS Israeli New Shekel  ₪   20aa
INR Indian Rupee    ₹   20b9
ISK Iceland Krona   kr  6b, 72
JMD Jamaican Dollar J$  4a, 24
JPY Japanese Yen    ¥   a5
KRW South-Korean Won    ₩   20a9
LKR Sri Lanka Rupee ₨   20a8
MAD Moroccan Dirham .د.م    2e, 62f, 2e, 645
MMK Myanmar Kyat    K   4b
MXN Mexican Peso    $   24
MYR Malaysian Ringgit   RM  52, 4d
NOK Norwegian Kroner    kr  6b, 72
NZD New Zealand Dollar  $   24
PAB Panamanian Balboa   B/. 42, 2f, 2e
PEN Peruvian Nuevo Sol  S/. 53, 2f, 2e
PHP Philippine Peso ₱   20b1
PKR Pakistan Rupee  ₨   20a8
PLN Polish Zloty    zł  7a, 142
RON Romanian New Lei    lei 6c, 65, 69
RSD Serbian Dinar   RSD 52, 53, 44
RUB Russian Rouble  руб 440, 443, 431
SEK Swedish Krona   kr  6b, 72
SGD Singapore Dollar    S$  53, 24
THB Thai Baht   ฿   e3f
TND Tunisian Dinar  DT  44, 54
TRY Turkish Lira    TL  54, 4c
TTD Trinidad/Tobago Dollar  $   24
TWD Taiwan Dollar   NT$ 4e, 54, 24
USD US Dollar   $   24
VEF Venezuelan Bolivar Fuerte   Bs  42, 73
VND Vietnamese Dong ₫   20ab
XAF CFA Franc BEAC  FCFA    46, 43, 46, 41
XCD East Caribbean Dollar   $   24
XPF CFP Franc   F   46
ZAR South African Rand  R   52
*/