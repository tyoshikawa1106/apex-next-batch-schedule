@isTest
private class ApexSampleSchedulerTest {
    
    private static User testAdminUser = new User(Id = UserInfo.getUserId());

    /**
     * ApexSampleSchedulerTest
     */
    static testMethod void ApexSampleSchedulerTest() {
        
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