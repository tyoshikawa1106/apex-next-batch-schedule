public with sharing class ApexSampleConnect implements ApexSampleScheduler.IScheduler {
    
    /**
     * execute
     */
    public void execute(SchedulableContext sc) {
        Database.executeBatch(new ApexSampleBatch(), 200);
    }
}