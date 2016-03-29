with Ada.Text_IO;use Ada.Text_IO;
with Ada.Integer_Text_IO;

procedure Prac_2 is 
    task HundredNumbers;
    task body HundredNumbers is
    begin
        for I in 1 .. 100 loop
            Put_line(Integer'Image(I));
        end loop;
    end HundredNumbers;

    task Alphabet;
    task body Alphabet is
    begin
        for i in Character range 'a' .. 'z' loop
            Put_Line(Character'Image(i));
        end loop;
        for i in Character range 'A' .. 'Z' loop
            Put_Line(Character'Image(i));
        end loop;
    end Alphabet;
begin
    null;
end Prac_2;
