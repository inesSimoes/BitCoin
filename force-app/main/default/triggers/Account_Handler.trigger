trigger Account_Handler on Account (before update) {
	 if (Trigger.isBefore && Trigger.isUpdate) {
        List<Account> accList = new List<Account>();
        for (Account test: Trigger.new) {
          If(!checkRecursive.SetOfIDs.contains(test.Id)){
            checkRecursive.SetOfIDs.add(test.Id);
            UpdateAccount updateJob = new UpdateAccount(test);
            ID jobID = System.enqueueJob(updateJob);
          }
      }
    }
    //List<Account> lstacc = [SELECT ID, Annual_Revenue_in_Bitcoin__c, AnnualRevenue FROM Account where id IN trigger.new];
    
}