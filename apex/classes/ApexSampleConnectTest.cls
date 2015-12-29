@isTest
private class ApexSampleConnectTest {
    
    private static User testAdminUser = new User(Id = UserInfo.getUserId());

    /**
     * ApexSampleConnectTest
     */
    static testMethod void ApexSampleConnectTest() {
        
        System.runAs(testAdminUser) {

            Test.startTest();
            
            ApexSampleScheduler cls = new ApexSampleScheduler();
            // パラメータ
            String sch = '0 0 1 1 JAN ?';
            // バッチスケジュール起動
            System.schedule('ApexSampleSchedulerTestJob',sch, cls);  
            
            Test.stopTest();
        }
    }
}