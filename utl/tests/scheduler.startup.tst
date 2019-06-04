PL/SQL Developer Test script 3.0
41
--  File name:                  $Workfile:  $
--  Source Control version:     $Revision: 1.1 $
--  Last modified by:           $Author: apenney $
--  Source Control location:    $Archive:  $
declare
  v_start   number;
  v_end     number;
  v_retcode integer;
  i         integer;
  v_job     pls_integer;
begin
  dbms_output.put_line('Start ');
  v_start := dbms_utility.get_time;

  -- Test statements
  util.scheduler.startup(p_interval in pls_integer := null);  
  select job
    into v_job
    from sys.dba_jobs
   where what like '%scheduler.fsm%';


  -- Test analysis
  if(v_job is not null)then
    v_retcode:=0;
  else
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
