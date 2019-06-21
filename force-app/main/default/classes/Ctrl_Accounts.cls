public class Ctrl_Accounts {
    // create a wrapper class with @AuraEnabled Properties    
	 public class AccountPagerWrapper {
   		@AuraEnabled public Integer pageSize {get;set;}
    	@AuraEnabled public Integer page {get;set;}
    	@AuraEnabled public Integer total {get;set;}
    	@AuraEnabled public List<Account> accounts {get;set;}
	}
    
    @AuraEnabled
    public static AccountPagerWrapper getAccounts(Decimal pageNumber) {
      	Integer offset = ((Integer)pageNumber - 1) * 5;
    
    	// create a instance of wrapper class.
    	AccountPagerWrapper obj =  new AccountPagerWrapper();
    	// set the pageSize,Page(Number), total records and accounts List(using OFFSET)   
        obj.pageSize = 5;
        obj.page = (Integer) pageNumber;
        obj.total = [SELECT count() FROM account];
        obj.accounts = [SELECT Id, Name FROM Account ORDER BY Name LIMIT 5 OFFSET :offset];
    	// return the wrapper class instance .
        return obj;
     }
    
    
    
    //Handle selected values
    @AuraEnabled 
    public static string createOpportunities(decimal amount, string stage, date closedate, List<String> Ltaccounts){
        if(Ltaccounts.isEmpty()){
            return 'Please, select an Account.';
        }else{
        List<Opportunity> opps = new List<Opportunity>();
        String message = '';
        system.debug('LtAccounts ' +Ltaccounts );
        system.debug('Amount ' + amount );
        system.debug('closedate ' +  closedate);
        system.debug('stage ' + stage );
        for(String acc : Ltaccounts){
            opportunity opp = new opportunity();
            opp.Name = 'New auto opportunity created for ' + acc;
            opp.Amount = amount;
            opp.StageName = stage;
            opp.CloseDate = closedate;
            opps.add(opp) ;
        }
  
        try{
        insert opps;
       		message = 'Completed Successfully!';
        }catch (Exception e){
            system.debug('Exception' + e);
            message = 'Exception!  ' +  e ;
        }
        return message;
        }
    }
    
    
}