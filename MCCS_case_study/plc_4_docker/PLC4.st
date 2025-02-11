PROGRAM PLC4

  VAR
    locD AT %IW0 : INT;
	cylD_can_move AT %QX0.0 : BOOL := False;
    moving_cylD_to_down AT %QX0.1 : BOOL := True;
    object_is_moving_from_y_to_z AT %QX0.2 : BOOL := False;
    cylD AT %QW0 : INT;
    cylDEndLoc AT %MW1 : INT := 5;
  END_VAR
  
  IF cylD_can_move THEN
  	IF moving_cylD_to_down THEN 
  		IF locD = cylDEndLoc THEN
  		    object_is_moving_from_y_to_z := NOT(object_is_moving_from_y_to_z);
  			moving_cylD_to_down := False;
  			cylD := 0;
  		ELSE cylD := 1;
  		END_IF;
  	ELSE
  		IF locD = 0 THEN
  			cylD_can_move := False;
  			moving_cylD_to_down := True;
  			cylD := 0;
  		ELSE cylD := 2;
  		END_IF;
  	END_IF;
  END_IF;
  
END_PROGRAM

CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : PLC4;
  END_RESOURCE
  
END_CONFIGURATION
