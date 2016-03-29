pragma Task_Dispatching_Policy(FIFO_Within_Priorities);

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Real_Time.Timing_Events; use Ada.Real_Time.Timing_Events;
with System;

procedure Prac_8 is
    TE : aliased Timing_Event;
    Period : Time_Span := Milliseconds(100);
    Start_Time : Time := Clock + Period;

    protected Releaser is
        entry Wait_Next_Release;
        procedure Release(Event : in out Timing_Event);
    private
        Go : Boolean := false;
    end Releaser;

    protected body Releaser is
        entry Wait_Next_Release when Go is
        begin
            Go := false;
        end Wait_Next_Release;
    
        procedure Release(Event: in out Timing_Event) is
        begin
            Go := true;
            -- schedule next release
            Event.Set_Handler(Clock + Period, Release'Unrestricted_Access);
        end Release;
    end Releaser;

    task Worker is
        pragma Priority(System.Priority'First);
    end Worker;

    task Periodic is
        pragma Priority(System.Priority'First + 5);
    end Periodic;
    
    task body Periodic is
        Period : Integer := 100;
        Iterations : Integer := 10;
    begin
        -- schedule first release
        TE.Set_Handler(Start_Time, Releaser.Release'Unrestricted_Access); 

        for i in 1 .. 10 loop
            Releaser.Wait_Next_Release;
            Put_Line("High priority periodic is running...");
        end loop;
        null;
    end Periodic;

    task body Worker is
        A : Integer := 0;
    begin
        delay until Start_Time;
        
        -- repeat task 100 times
        for I in 1 .. 50 loop
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
end Prac_8;
