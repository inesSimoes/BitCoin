({
	// Fetch the accounts from the Apex controller
      getAccountList: function(component,page) {
        var today = new Date(); 
        var action = component.get('c.getAccounts');
          action.setParams({
         "pageNumber": page
         });
        // Set up the callback
        var self = this;
        action.setCallback(this, function(actionResult) {
         var result = actionResult.getReturnValue();
         component.set('v.today', today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate());  
         component.set('v.AccountList', result.accounts);
         component.set("v.page", result.page);
         component.set("v.total", result.total);
         component.set("v.pages", Math.ceil(result.total / 5));
        });
        $A.enqueueAction(action);
      },
    
    //Create Opportunities
    createOpportunities: function( component, amount, stage, closedate, selectedAccounts){
        var action = component.get('c.createOpportunities');
        action.setParams({
            "amount" : amount ,
            "stage" : stage ,
            "closedate" : closedate ,
            "Ltaccounts" : selectedAccounts
        });
        action.setCallback(this, function(actionResult) {
            console.log(actionResult.getState());
            console.log('amount ' + amount);
            console.log('stage ' + stage);
            console.log('closedate ' + closedate);
            console.log('LtAccounts ' + selectedAccounts);
            alert(actionResult.getReturnValue());
        });
        $A.enqueueAction(action);
        alert(actionResult.getState());
    }
})