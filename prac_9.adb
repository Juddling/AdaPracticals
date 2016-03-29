with Infinite_Work;
with Ada.Text_IO; use Ada.Text_IO;

procedure Prac_9 is
    task Worker;
    task body Worker is
    begin
        select
            delay 1.0;
            
            Put_Line("Will this ever print");
        then abort
            Infinite_Work;
        end select;
    end Worker;
begin
    null;
end Prac_9;
