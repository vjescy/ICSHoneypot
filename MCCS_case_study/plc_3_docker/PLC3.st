PROGRAM PLC3

  VAR
    locC AT %IW0 : INT;
	cylC_can_move AT %QX0.0 : BOOL := False;
    moving_cylC_to_left AT %QX0.1 : BOOL := True;
    cylC AT %QW0 : INT;
    cylCEndLoc AT %MW1 : INT := 5;
  END_VAR
  
  IF cylC_can_move THEN
  	IF moving_cylC_to_left THEN 
  		IF locC = cylCEndLoc THEN
  			cylC_can_move := False;
  			moving_cylC_to_left := False;
  			cylC := 0;
  		ELSE cylC := 1;
  		END_IF;
  	ELSE
  		IF locC = 0 THEN
  			cylC_can_move := False;
  			moving_cylC_to_left := True;
  			cylC := 0;
  		ELSE cylC := 2;
  		END_IF;
  	END_IF;
  END_IF;
  
END_PROGRAM

CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : PLC3;
  END_RESOURCE
  
END_CONFIGURATION
