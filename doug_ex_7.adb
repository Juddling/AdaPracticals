pragma Task_Dispatching_Policy(FIFO_Within_Priorities);
with Ada.Text_IO; use Ada.Text_IO; 
with System;
with Ada.Real_Time; use Ada.Real_Time;

procedure Doug_Ex_7 is 

    Start_Time : Time := Clock + Milliseconds(100);


        task Periodic is 
            pragma Priority(System.Priority'First);
        end Periodic;

        task Task2 is 
            pragma Priority(System.Priority'First + 5); 
        end Task2;

        task body Periodic is 
            Next_Release : Time := Start_Time; 
            Release_Interval : Time_Span := Milliseconds(100);
        begin
            for i in 1..15 loop
                delay until Next_Release;
                Put_Line("Periodic Task: " & Integer'Image(i));
                Next_Release := Next_Release + Release_Interval;
            end loop;
            --null;
        end Periodic;

        task body Task2 is 
            I : Integer := 0;
            F : Integer := 0;
        begin 
            delay until Start_Time;
            loop 
                Put_Line("Task 2 Executing" & Integer'Image(I));

                for J in 1..10000000 loop 
                    F := J * 3;
                end loop; 

                I := I + 1; 
                exit when I = 50;
            end loop;
            Put_Line("Task 2 Terminating");
        end Task2;



begin 
    null;
end Doug_Ex_7;
