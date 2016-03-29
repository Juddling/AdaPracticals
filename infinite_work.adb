with Ada.Text_IO; use Ada.Text_IO;

procedure Infinite_work is
    F : Integer := 0;
begin
    Put_Line("Working");

    loop
        for J in 1 .. 1000000 loop
            F := J * 10;
        end loop;
        Put_Line("Still working");
    end loop;
end Infinite_Work;
