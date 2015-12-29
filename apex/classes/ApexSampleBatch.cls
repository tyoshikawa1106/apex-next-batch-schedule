public with sharing class ApexSampleBatch implements Database.Batchable<sObject>, Database.Stateful {

    /**
     * コンストラクタ
     */
    public ApexSampleBatch() {
    
    }

    /**
     * start
     */
    public Database.QueryLocator start(Database.BatchableContext BC) {
        String query = ' SELECT Id,Name FROM User WHERE IsActive = true ';
        return Database.getQueryLocator(query);
    }
    
    /**
     * execute
     */
    public void execute(Database.BatchableContext BC, List<User> users) {
        for (User u : users) {
            System.debug(u.Id + ' : ' + u.Name);
        }
    }
    
    /**
     * Finish
     */
    public void finish(Database.BatchableContext BC) {
        // Target Date
        Date targetDate = System.today().addYears(1);
        // Get Next Batch Name
        String nextBatchName = this.getNextBatchName(targetDate);
        // Get Schedule Batch Count
        Integer scheduleBatchCount = this.getScheduleBatchCount(nextBatchName);
        // Next Batch Schedule
        if (scheduleBatchCount == 0) {
            this.doNextBatchSchedule(nextBatchName, targetDate);
        }
    }
    
    /**
     * Get Next Batch Name
     */
    @TestVisible
    private String getNextBatchName(Date targetDate) {
        String targetYear = String.valueOf(targetDate.year());
        String nextBatchName = targetYear + '_ApexSampleBatch';
        return nextBatchName;
    }
    
    /**
     * Get Schedule Batch Count
     */
    @TestVisible
    private Integer getScheduleBatchCount(String nextBatchName) {
        return [SELECT COUNT() FROM CronJobDetail WHERE Name = :nextBatchName];
    }
    
    /**
     * Next Batch Schedule
     */
    @TestVisible
    private void doNextBatchSchedule(String nextBatchName, Date targetDate) {
        ApexSampleScheduler cls = new ApexSampleScheduler();
        String sch = '0 0 1 1 JAN ? ' + String.valueOf(targetDate.year());
        System.schedule(nextBatchName, sch, cls);
    }
}