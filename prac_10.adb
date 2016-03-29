pragma Task_Dispatching_Policy(FIFO_Within_Priorities);

with Infinite_Work;
with System; use System;
with Ada.Text_IO; use Ada.Text_IO;

procedure Prac_10 is
    protected Controlled_Interrupt is
        entry Wait_For_Release;
        procedure Trigger_Release;
    private
        Release : boolean := false;
    end Controlled_Interrupt;

    protected body Controlled_Interrupt is
        entry Wait_For_Release when Release is
        begin
            -- what to do when it gets entry
            Release := False;
        end Wait_For_Release;
        procedure Trigger_Release is
        begin
            Release := true;
        end Trigger_Release;
    end Controlled_Interrupt;

    task Worker is
        pragma Priority(System.Priority'First + 1);
    end Worker;

    task body Worker is
    begin
        select
            Controlled_Interrupt.Wait_For_Release;
            Put_Line("Interrupted");
        then abort
            Infinite_Work;
        end select;
    end Worker;

    task Boss is
        pragma Priority(System.Priority'First + 5);
    end Boss;

    task body Boss is
    begin
        delay 0.5;
        Controlled_Interrupt.Trigger_Release;
    end Boss;
begin
    null;
end Prac_10;
