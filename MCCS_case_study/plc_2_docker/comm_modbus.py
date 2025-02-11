import modbus_tk.defines as cst
import modbus_tk.modbus_tcp as modbus_tcp
import time

#wait for plc to be ready
time.sleep(5)

plc_IP_addresses = ['localhost','172.17.0.3'] # plc2 sends signal only to plc1
plcs = [] # plc connections
mod_port = 502 # modbus port

#connect to plcs with modbus
for i in range(len(plc_IP_addresses)):

    while True:
        try:
            plc = modbus_tcp.TcpMaster(plc_IP_addresses[i], mod_port)
            plc.set_timeout(5.0)
            break
        except:
            print("connection error!!!")
    
    plcs.append(plc)

print("-- Connections done!!! --")

turn_list = [1] # array which contains the sequence to follow for sending the signals to plcs
               # ex. If the PLC has to send a signal first to PLC1 and then to PLC2, the array will be [1, 2], where
               # 1 and 2 are respectly the position of plc1 and plc2 socket in plc_conn_list!!!

first = True # If the local plc is the first to start
next_plc = 0 # To scroll the turn_list array

while True:

    if next_plc != len(turn_list):

        # reading the local plc coil register
        try:
            value = plcs[0].execute(1,cst.READ_COILS,0,1)
        except:
            print("Reading error")

        if int(value[0]) == 1 or first == True:
            
            while True:

                # reading the local plc coil register
                try:
                    value = plcs[0].execute(1,cst.READ_COILS,0,1)
                except:
                    print("Reading error")

                if int(value[0]) == 0:

                    # sending signal to the other plc
                    try:
                        value = plcs[turn_list[next_plc]].execute(1,cst.WRITE_SINGLE_COIL,0,output_value=1)
                        print("Signal sent")
                        break
                    except:
                        print("Writing error")
                        
            first = False
            next_plc += 1
            
    else:
        next_plc = 0
