import modbus_tk
import modbus_tk.defines as cst
import modbus_tk.modbus_tcp as modbus_tcp
import time

stop_flag = False

while not stop_flag:
    try:
        #connect to plc
        plc = modbus_tcp.TcpMaster('172.17.0.3', 502)
        plc.set_timeout(5.0)
        stop_flag = True
        print("Connection done!!!")
    except:
        print("error during connectin to the plc!!!")
        time.sleep(1)

while True:

    try:
        #writing plc's coil
        plc.execute(0, cst.WRITE_SINGLE_COIL, 0, output_value=1)
        #time.sleep(0.02)

    except:
        print("writing error!!!")
        break

plc.close()
