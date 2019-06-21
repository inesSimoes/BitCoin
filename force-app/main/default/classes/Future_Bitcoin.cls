global with sharing class Future_Bitcoin {
  	
    public static Decimal ValueOfOneBitcoinInUSD;
    
    
    public decimal Future_Bitcoin(){
        getTheValueOfOneBitcoinInUSD();
        decimal dollar = ValueOfOneBitcoinInUSD;
        return dollar;
      }
    
    @Future(callout=true)
    public static void getTheValueOfOneBitcoinInUSD(){
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
                            ValueOfOneBitcoinInUSD = parser.getDoubleValue();
                            system.debug('rate: ' + ValueOfOneBitcoinInUSD);
                        }
                }
            }
			
        }
      }
	
}