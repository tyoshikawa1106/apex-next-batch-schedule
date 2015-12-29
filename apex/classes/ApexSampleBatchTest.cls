@isTest
private class ApexSampleBatchTest {
    
    private static User testAdminUser = new User(Id = UserInfo.getUserId());
    
    /**
     * ApexSampleBatchTest1
     */
    static testMethod void ApexSampleBatchTest1() {
        
        System.runAs(testAdminUser) {

            Test.startTest();
            
            ApexSampleBatch batch = new ApexSampleBatch();
            Database.executeBatch(batch, 200);
            
            Test.stopTest();

            String nextBatchName = '%_ApexSampleBatch';
            Integer result = [SELECT COUNT() FROM CronJobDetail WHERE Name Like: nextBatchName];
            System.assertNotEquals(result, 0);
        }
    }
    
    /**
     * Get Next Batch Name
     */
    static testMethod void getNextBatchNameTest1() {
        
        System.runAs(testAdminUser) {

            Test.startTest();
            
            ApexSampleBatch cls = new ApexSampleBatch();
            // 2015
            String result = cls.getNextBatchName(Date.newInstance(2015, 1, 1));
            System.assertEquals(result, '2015_ApexSampleBatch');
            // 2016
            result = cls.getNextBatchName(Date.newInstance(2016, 1, 1));
            System.assertEquals(result, '2016_ApexSampleBatch');
            
            Test.stopTest();
        }
    }
    
    /**
     * Get Schedule Batch Count
     */
    static testMethod void getScheduleBatchCountTest1() {
        
        System.runAs(testAdminUser) {

            Test.startTest();
            
            ApexSampleBatch cls = new ApexSampleBatch();
            // 値なし
            String nextBatchName = '';
            Integer result = cls.getScheduleBatchCount(nextBatchName);
            System.assertEquals(result, 0);
            
            Test.stopTest();
        }
    }
    
    /**
     * Next Batch Schedule
     */
    static testMethod void doNextBatchScheduleTest1() {
        
        System.runAs(testAdminUser) {
            
            // コンストラクタ
            ApexSampleBatch cls = new ApexSampleBatch();
            // param
            Date targetDate = System.today().addYears(1);
            String nextBatchName = String.valueOf(targetDate.year()) + '_ApexSampleBatch_Test';

            Test.startTest();
            
            cls.doNextBatchSchedule(nextBatchName, targetDate);
            
            Test.stopTest();
            
            // Result
            Integer result = [SELECT COUNT() FROM CronJobDetail WHERE Name =: nextBatchName];
            System.assertEquals(result, 1);
        }
    }
}