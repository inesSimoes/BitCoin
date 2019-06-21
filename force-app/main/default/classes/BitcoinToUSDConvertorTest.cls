@isTest
public class BitcoinToUSDConvertorTest {

    static testMethod void constructorGetsTheValueOfOneValueOfOneBitcoinInUSDFromTheApiTest(){
              
              // Create the mock response based on a static resource
               StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
               mock.setStaticResource('StaticRate');
               mock.setStatusCode(200);
               mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
              // Associate the callout with a mock response
              Test.setMock(HttpCalloutMock.class, mock);
              
              Test.startTest();
              BitcoinToUSDConvertor class_instance = new BitcoinToUSDConvertor();
              Test.stopTest();
              
              System.assertEquals(7946.06498, class_instance.BitcoinToUSDConvertor());
              
        
    }
}