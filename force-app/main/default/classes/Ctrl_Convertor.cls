public class Ctrl_Convertor {

    @AuraEnabled
    public static decimal getDollar(decimal bitcoin){
        BitcoinToUSDConvertor bit = new BitcoinToUSDConvertor();
        decimal dollar = bitcoin * bit.BitcoinToUSDConvertor();
        return dollar;
    }
    
    @AuraEnabled
    public static decimal getBitcoin(decimal dollar){
        BitcoinToUSDConvertor bit = new BitcoinToUSDConvertor();
        decimal bitcoin = dollar / bit.BitcoinToUSDConvertor();
        return bitcoin;
    }
}