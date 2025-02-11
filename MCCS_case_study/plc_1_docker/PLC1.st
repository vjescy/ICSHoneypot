PROGRAM PLC1

  VAR
    locA AT %IW0 : INT;
    cylA_can_move AT %QX0.0 : BOOL := False;
    moving_cylA_to_right AT %QX0.1 : BOOL := True;
    cylA AT %QW0 : INT;
    cylAEndLoc AT %MW1 : INT := 5;
  END_VAR
  
  IF cylA_can_move THEN
  	IF moving_cylA_to_right THEN 
  		IF locA = cylAEndLoc THEN
  			cylA_can_move := False;
  			moving_cylA_to_right := False;
  			cylA := 0;
  		ELSE cylA := 1;
  		END_IF;
  	ELSE
  		IF locA = 0 THEN
  			cylA_can_move := False;
  			moving_cylA_to_right := True;
  			cylA := 0;
  		ELSE cylA := 2;
  		END_IF;
  	END_IF;
  END_IF;
  
END_PROGRAM

CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : PLC1;
  END_RESOURCE
  
END_CONFIGURATION
