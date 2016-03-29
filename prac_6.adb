with Ada.Text_IO;use Ada.Text_IO;

procedure Prac_6 is
    type ClientID is new Integer range 1 .. 10;
    type Bools is array(ClientID'Range) of Boolean;
    
    task type Client(ID : ClientID);

    Release_ID : ClientID := 3;

    protected Controller is
        entry Public(ID : ClientID);
    private
        entry Wait_For_Release(ClientID)(ID : ClientID);

        Requests : Integer := 0;
        Released : Bools := (others => false);
        -- Barrier_Open : Boolean := false;
    end Controller;

    protected body Controller is
        entry Public(ID : ClientID) 
        when true is
        begin
            Put("Client ID:" & ClientID'Image(ID));
            
            if ID = Release_Id then
                Put_Line(" has released the barrier");
                Released(ClientID'first) := true;
                -- Barrier_Open := true;
            else
                Put_Line(" blocked");
            end if;
            
            -- log that this client has made a request
            Requests := Requests + 1;
            
            requeue Wait_For_Release(ID) with abort;

        end Public;
    
        entry Wait_For_Release(for I in ClientID)(ID : ClientID)
        when Released(I) and Requests = 5 is
        begin
        
            Put_Line("Task " & ClientID'Image(ID) & " has been released");
            Released(ID + 1) := true;

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
end Prac_6;
