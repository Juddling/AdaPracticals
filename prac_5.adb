with Ada.Text_IO;use Ada.Text_IO;

procedure Prac_5 is
    type ClientID is new Integer range 1 .. 10;

    task type Client(ID : ClientID);


    Release_ID : ClientID := 3;

    protected Controller is
        entry Public(ID : ClientID);
    private
        entry Wait_For_Release(ID : ClientID);

        Barrier_Open : Boolean := false;
    end Controller;

    protected body Controller is
        entry Public(ID : ClientID) 
        when true is
        begin
            Put("Client ID:" & ClientID'Image(ID));
            
            if ID = Release_Id then
                Put_Line(" has released the barrier");
                Barrier_Open := true;
            else
                Put_Line(" locked");

                requeue Wait_For_Release with abort;
            end if;

        end Public;
    
        entry Wait_For_Release(ID : ClientID)
        when Barrier_Open is
        begin
        
            Put_Line("Task " & ClientID'Image(ID) & " has been released");
        
            -- if this is the last task to be released then re-establish the barrier
            if Wait_For_Release'count = 0 then
                Barrier_Open := false;
            end if;

        end Wait_For_Release;
    end Controller;

    task body Client is
    begin
        
        select
            Controller.Public(ID);
        or
            delay 1.0;
            
            Put_Line("Task" & ClientID'Image(ID) & " timed out");
        end select;

    end Client;
    
    Client1 : Client(1);
    Client2 : Client(2);
    Client3 : Client(3);
    Client4 : Client(4);
    Client5 : Client(5);

begin
    null;
end Prac_5;
