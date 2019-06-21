public class UpdateAccounts2 implements Queueable, Database.AllowsCallouts {
    
    private List<Account> accounts;
    private decimal ValueOfOneBitcoinInUSD;
    
    
    public UpdateAccounts2(List<Account> records) {
        this.accounts = records;  
    }
    
    public void execute(QueueableContext context) {
        if(Recursion.quoteRecursion)
        return;
        Recursion.quoteRecursion = true;
        
        
        
        for (Account acc : accounts) {
        
            
        //make callout
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://bitpay.com/api/rates/');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            JSONParser parser = JSON.createParser(response.getBody());
        	String code = '';
            Double rate = 0.0;
        	while (parser.nextToken() != null) {
            	if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&
                	(parser.getText() == 'code')) {
                	parser.nextToken();
                	code = parser.getText();
                        if(code=='USD'){
                            system.debug('code : ' + code);
                            parser.nextToken();//Name
                            parser.nextToken();//Name Value
                            parser.nextToken();//Rate
                            parser.nextToken();//Rate Value
                            acc.Annual_Revenue_in_Bitcoin__c = acc.AnnualRevenue / parser.getDoubleValue();
                            system.debug('acc.Annual_Revenue_in_Bitcoin__c: ' + acc.Annual_Revenue_in_Bitcoin__c);
                        }
                }
            }
			
        }
        }
        update accounts;
    }
    
}