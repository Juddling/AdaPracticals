with Ada.Text_IO;use Ada.Text_IO;

procedure Prac_1 is
    task HelloWorld;
    task body HelloWorld is
    begin
        Put_line("Hello world");
    end HelloWorld;
begin
    null;
end Prac_1;
