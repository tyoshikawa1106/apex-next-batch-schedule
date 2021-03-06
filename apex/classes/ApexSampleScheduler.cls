public class ApexSampleScheduler implements Schedulable {
    
    private static final String CONNECT_CLASS = 'ApexSampleConnect';

    /**
     * コンストラクタ
     */
    public ApexSampleScheduler() {
        
    }

    /**
     * Interface
     */
    public Interface IScheduler {
        void execute(SchedulableContext sc);
    }

    /**
     * execute
     */
    public void execute(SchedulableContext sc) {
        Type targetType = Type.forName(CONNECT_CLASS);
        
        if(targetType != null) {
            IScheduler schedule = (IScheduler)targetType.NewInstance();
            schedule.execute(sc);
        }
    }
}