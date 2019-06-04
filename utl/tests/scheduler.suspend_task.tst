PL/SQL Developer Test script 3.0
56
--  File name:                  $Workfile:  $
--  Source Control version:     $Revision: 1.1 $
--  Last modified by:           $Author: apenney $
--  Source Control location:    $Archive:  $
declare
  v_start   number;
  v_end     number;
  v_retcode integer;
  i         integer;
  v_exp     varchar2(1000);
  v_state   varchar2(30);
begin
  dbms_output.put_line('Start ');
  v_start := dbms_utility.get_time;

  -- Test statements  
  i:=util.scheduler.add_task(null,    -- Type of task: DURABLE (default), VOLATILE, RESTARTABLE
                             'test1'  -- Name of a group of operations
                              10,     -- Notional Operation Id for a particular job. Other jobs
                              null,   -- Logical dependency statement of operations that need to
                              null,   -- Time to wait (in minutes) for predecessor jobs to complete before aborting. Null = wait forever.
                              'null',  -- The SQL Code to be scheduled
                              null,   -- Max allowable job runtime minutes. If NULL, then there is no max run time.
                              null,  -- Year in which this job is scheduled
                              null,   -- Month in which this job is scheduled
                              null,   -- Day of month in which this job is scheduled. When it is a negative number, the days will be count backwards from the last day of the month.
                              null,  -- Hour of day in which this job is scheduled
                              null,  -- Minute of day in which this job is scheduled
                              null,  -- Days in week when this job is scheduled, 7=SUNDAY,1=MONDAY, etc. e.g. 1..45.7
                              null.  -- Either INCLUDE or EXCLUDE days specified in table TB_SPECIAL_DAYS
                              null,  -- Number of times to repeat this task
                              null,  -- Interval in seconds over which to repeat this task
                              'Test task for removal' -- Description of what this task does
  );                                                          
  v_retcode:=util.scheduler.suspend_task(i);
  select state
    into v_state
    from util.tb_schedules
   where task_id = i;
  if(v_state<>util.scheduler.gc_state_SUSPENDED)then
    v_retcode:=-1;
  end if;
  

  -- Test Summary
  if(v_retcode=0) then
    dbms_output.put_line('Success.');
  else
    dbms_output.put_line('Failure. Error Code: '||v_retcode||'.');
  end if;
  v_end := dbms_utility.get_time;
  dbms_output.put_line('Time taken : '||(v_end-v_start)/100||' seconds');
exception
  when others then
    dbms_output.put_line('* Exception: Error Code: '||to_char(sqlcode)||' in $Workfile: $. Message: '||sqlerrm||'.');
end;
0
