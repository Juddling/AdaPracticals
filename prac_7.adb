pragma Task_Dispatching_Policy(FIFO_Within_Priorities);

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with System;

procedure Prac_7 is

    Start_Time : Time := Clock + Milliseconds(100);

    task Worker is
        pragma Priority(System.Priority'First + 5);
    end Worker;

    task Periodic is
        pragma Priority(System.Priority'First);
    end Periodic;
    
    task body Periodic is
        Period : Integer := 100;
        Iterations : Integer := 10;
    begin 
        for i in 1 .. 10 loop
            -- schedule for next period
            delay until Clock + Milliseconds(100);
            Put_Line("High priority periodic is running...");
        end loop;
        null;
    end Periodic;

    task body Worker is
        A : Integer := 0;
    begin
        delay until Start_Time;
        
        -- repeat task 100 times
        for I in 1 .. 100 loop
            Put_Line("Low prio executing...");

            -- do some computation to waste time
            A := 0;
            for J in 1 .. 10000000 loop
                A := A * 3;
            end loop;
        end loop;

        Put_Line("Low prio terminated");
    end Worker;

begin
    null;
end Prac_7;
