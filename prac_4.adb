with Ada.Text_IO;use Ada.Text_IO;

procedure Prac_4 is
    -- shared array
    --
    A: array (Integer range 1..10) of Integer;
    pragma Volatile(A);

    protected Turn is
        entry Can_One_Write(Index : Integer);
        entry Can_Seven_Write(Index : Integer);
        procedure Write(Index, Value: in Integer);
    private
        State : Integer := 0;
        -- 0 = Initial write of 1
        -- 1 = Overwrite 1 with 7
        -- 2 = Initial write of 7
        -- 3 = Overwrite 7 with 1
    end Turn;

    protected body Turn is
        entry Can_One_Write(Index : Integer) 
        when State mod 4 = 0 or State mod 4 = 3 is
        begin
            
            Write(Index, 1);

        end Can_One_Write;

        entry Can_Seven_Write(Index : Integer) 
        when State mod 4 = 1 or State mod 4 = 2 is
        begin
            Write(Index, 7);
        
        end Can_Seven_Write;

        procedure Write(Index, Value: in Integer) is
        begin
            -- Put("Wrote ");
            --Put(Integer'Image(Value));
            --Put("to Index ");
            --Put(Integer'Image(Index));
            --Put(" State:");
            --Put_Line(Integer'Image(State));

            A(Index) := Value;
            State := State + 1;
        end Write;
    end Turn;

    procedure Task_Control is 
        task One;
        task body One is
        begin
            -- delay 0.01;
            Put_Line("Task One is running...");

            for i in A'Range loop
                Turn.Can_One_Write(i);
            end loop;
        exception when others => Put_Line("Task One Exception");
        end One;

        task Seven;
        task body Seven is
        begin
            Put_Line("Task Seven is running...");

            for i in A'Range loop
                Turn.Can_Seven_Write(i);
            end loop;
        exception when others => Put_Line("Task Seven Exception");
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
end Prac_4;
