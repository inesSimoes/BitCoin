({
	handleClick1 : function(component, event, helper) {
        var action = component.get("c.getDollar");
        console.log("testing");
        console.log(component.find('bitcoin').get('v.value'));
        action.setParams({  
            bitcoin  :  component.find('bitcoin').get('v.value')
        });// setting the parameter to apex class method
		action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.USDollar", response.getReturnValue());
                console.log(response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    },
    
    handleClick2 : function(component, event, helper) {
        var action = component.get("c.getBitcoin");
        console.log(component.find('bitcoin').get('v.value'));
        action.setParams({  
            dollar  :  component.find('dollar').get('v.value')
        });// setting the parameter to apex class method
		action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.bitcoin", response.getReturnValue());
                console.log(response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    }
})