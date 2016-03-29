with Ada.Text_IO;use Ada.Text_IO;

procedure Prac_3 is
    -- shared array
    --
    A: array (Integer range 1..100) of Integer;
    pragma Volatile(A);

    procedure Task_Control is 
        task One;
        task body One is
        begin
            -- delay 0.01;
            Put_Line("Task One is running...");

            for i in A'Range loop
                A(i) := 1;
            end loop;
        end One;

        task Seven;
        task body Seven is
        begin
            Put_Line("Task Seven is running...");
            
            for i in A'Range loop
                A(i) := 7;
            end loop;
        end Seven;
    begin
        null; -- procedure will not complete until tasks are done
    end;
begin
    Task_Control; -- waits until tasks are complete
    
    -- print the global array
    for i in A'Range loop
        Put_Line(Integer'Image(A(i)));
    end loop;
end Prac_3;
