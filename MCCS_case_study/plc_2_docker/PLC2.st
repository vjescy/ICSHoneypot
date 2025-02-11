PROGRAM PLC2

  VAR
    locB AT %IW0 : INT;
	cylB_can_move AT %QX0.0 : BOOL := True;
    moving_cylB_to_down AT %QX0.1 : BOOL := True;
    object_is_moving_from_x_to_y AT %QX0.2 : BOOL := False;
    cylB AT %QW0 : INT;
    cylBEndLoc AT %MW1 : INT := 5;
  END_VAR
  
  IF cylB_can_move THEN
  	IF moving_cylB_to_down THEN 
  		IF locB = cylBEndLoc THEN
  		    object_is_moving_from_x_to_y := NOT(object_is_moving_from_x_to_y);
  			moving_cylB_to_down := False;
  			cylB := 0;
  		ELSE cylB := 1;
  		END_IF;
  	ELSE
  		IF locB = 0 THEN
  			cylB_can_move := False;
  			moving_cylB_to_down := True;
  			cylB := 0;
  		ELSE cylB := 2;
  		END_IF;
  	END_IF;
  END_IF;
  
END_PROGRAM

CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : PLC2;
  END_RESOURCE
  
END_CONFIGURATION
