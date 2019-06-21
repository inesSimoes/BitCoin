({
    //get Contact List from apex controller
    doInit : function(component, event, helper) {
        
         // this function call on the component load first time     
         // get the page Number if it's not define, take 1 as default
         var page = component.get("v.page") || 1;
            // call the helper function   
         helper.getAccountList(component, page);
    },
     
    //Select all contacts
    handleSelectAllAccounts: function(component, event, helper) {
        var getID = component.get("v.AccountList");
        var checkvalue = component.find("selectAll").get("v.value");        
        var checkContact = component.find("checkAccount"); 
        if(checkvalue == true){
            for(var i=0; i<checkContact.length; i++){
                checkContact[i].set("v.value",true);
            }
        }
        else{ 
            for(var i=0; i<checkContact.length; i++){
                checkContact[i].set("v.value",false);
            }
        }
    },
     
    //Process the selected Accounts
    handleSelectedAccounts: function(component, event, helper) {
        var selectedAccounts = [];
        var checkvalue = component.find("checkAccount");
        var amount = component.find("Amount").get("v.value");
        var stage = component.find("select").get("v.value");
        var closedate = component.find("CloseDate").get("v.value");
         
        if(!Array.isArray(checkvalue)){
            if (checkvalue.get("v.value") == true) {
                selectedAccounts.push(checkvalue.get("v.text"));
            }
        }else{
            for (var i = 0; i < checkvalue.length; i++) {
                if (checkvalue[i].get("v.value") == true) {
                    selectedAccounts.push(checkvalue[i].get("v.text"));
                }
            }
        }
       //if (typeof selectedAccounts !== 'undefined' && selectedAccounts.length > 0) {
       // the array is defined and has at least one element
       helper.createOpportunities(component, amount, stage, closedate,  selectedAccounts);
       //} else{
       //	alert("Please Select an Account!");
       //  }
    },
        
    navigate: function(component, event, helper) {
      // this function call on click on the previous page button  
      var page = component.get("v.page") || 1;
      // get the previous button label  
      var direction = event.getSource().get("v.label");
      // set the current page,(using ternary operator.)  
      page = direction === "Previous Page" ? (page - 1) : (page + 1);
      // call the helper function
      helper.getAccountList(component, page);
    }
})