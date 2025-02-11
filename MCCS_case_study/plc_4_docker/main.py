import socket
import psm
from time import sleep
import pickle as pkl
import json
import modbus_tk.defines as cst
import modbus_tk.modbus_tcp as modbus_tcp

#inital state variables
plc_input_reg_names = [] # plc's input registers nemes
plc_output_reg_names = [] # plc's output registers nemes
server_UDP_info = ('',0) # interface server address and port
client_UDP_info = ('',0) # physic simulator client address and port
udp_server = None # Socket for UDP server
modbus_client = None # Socket for Modbus client

# To extract the modbus address and read operation code from register name (ex. reg_name:"%QX0.0" modbus_address:0)
def extract_modbus_address(register_name):
    #init variables
    location = ""
    address = 0
    op = None

    #remove the optional '%' of the variable
    if ("%" in register_name):
        location = register_name.split("%")[1]
    else:
        location = register_name

    #get address
    if ("IX" in location):
        location = location.split("IX")[1]
        if ("." in location):
            address = 8*(int(location.split(".")[0])) + int(location.split(".")[1])
        else:
            address = int(location)
        op = cst.READ_DISCRETE_INPUTS
            
    elif ("QX" in location):
        location = location.split("QX")[1]
        if ("." in location):
            address = 8*(int(location.split(".")[0])) + int(location.split(".")[1])
        else:
            address = int(location)
        op = cst.READ_COILS
            
    elif ("IW" in location):
        location = location.split("IW")[1]
        if ("." in location):
            #invalid location
            location = ""
            address = 0
        else:
            address = int(location)
        op = cst.READ_INPUT_REGISTERS
            
    elif ("QW" in location):
        location = location.split("QW")[1]
        if ("." in location):
            #invalid location
            location = ""
            address = 0
        else:
            address = int(location)
        op = cst.READ_HOLDING_REGISTERS
    
    elif ("MW" in location):
        location = location.split("MW")[1]
        if ("." in location):
            #invalid location
            location = ""
            address = 0
        else:
            address = int(location) + 1024
        op = cst.READ_HOLDING_REGISTERS

    return op,address

# To initialize variables from json file
def initaialization_variables():
    global plc_input_reg_names
    global plc_output_reg_names
    global server_UDP_info
    
    plc_input_reg_names = []
    plc_output_reg_names = []
    server_UDP_info = ()
    
    #getting plc name
    try:
        file = open("/home/OpenPLC_v3/plc_name.txt")
    except Exception as error:
        print(error)

    try:
        plc_name = file.read()
    except Exception as error:
        print(error)

    # getting configuaration info
    try:
        config_file = open("/home/OpenPLC_v3/config.json")
    except Exception as error:
        print(error)

    try:
        config_data = json.load(config_file)
    except Exception as error:
        print(error)

    # getting plc input registers
    for input_reg in list(config_data["plcs"][plc_name]["registers"]["input_regs"].keys()):
        plc_input_reg_names.append(input_reg)
        
    # getting plc output registers
    for output_reg in list(config_data["plcs"][plc_name]["registers"]["output_regs"].keys()):
        plc_output_reg_names.append(output_reg)

    # getting PSM interface server ip and port
    server_UDP_info = (config_data["plcs"][plc_name]["ip"],config_data["plcs"][plc_name]["port"])

# To start interface UDP server
def starting_udp_server():
    global udp_server
    global server_UDP_info
    
    try:
        udp_server = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        udp_server.bind(server_UDP_info)
        print("Server UDP up!!!")
    except socket.error as error:
        print("error during UDP server initialization!!!")

# To start Modbus client
def starting_modbus_client():
    global modbus_client

    sleep(5) # Waiting PLC initialization
    
    while True:
        try:
            # Connecting to plc
            modbus_client = modbus_tcp.TcpMaster('127.0.0.1', 502)
            modbus_client.set_timeout(5.0)
            print("Connection to Modbus server done!!!")
            break
        except:
            print("error during connectin to the plc!!!")

def hardware_init():
    
    psm.start()

    # initializing variables
    initaialization_variables()

    # starting the UDP server
    starting_udp_server()

    # starting the Modbus client
    starting_modbus_client()

# to update PLC's input registers, or any other PLC register
def get_input_from_sim():
    global plc_input_reg_names
    global udp_server
    global client_UDP_info
    
    # Getting datas from the physical simulator client
    [data,client_UDP_info]  = udp_server.recvfrom(1024)
    sensors_states = pkl.loads(data) # deserialization of received data from PSM interface
    
    print("sensors states: ")
    # updating the PLC's input registers
    for i in range(len(sensors_states)):
        value = int(float(sensors_states[i]))
        psm.set_var(plc_input_reg_names[i], value) # psm function
        print( plc_input_reg_names[i] + " : " + str(value))
        
# to send actuator states to the physics simulator
def send_output_to_sim():
    global plc_output_reg_names
    global udp_server
    global client_UDP_info
    global modbus_client
    
    actuators_states = []
    print("actuators states: ")
    # reading values from PLC's registers
    for reg in plc_output_reg_names:
        
        # Reading coils from main OpenPLC Modbus server
        try:
            op,address = extract_modbus_address(reg)
            value = modbus_client.execute(1, op, address, 1)
            actuators_states.append(value[0])
            print( reg + " : " + str(value[0]) )
        except:
            print("Reading error")
    
    print("\n")

    # sending actauators states to the simulator client
    serializad_data = pkl.dumps(actuators_states) # data serialization
    udp_server.sendto(serializad_data, client_UDP_info) 

if __name__ == "__main__":

    hardware_init()

    print(plc_input_reg_names)
    print(plc_output_reg_names)
    print(server_UDP_info)
    
    while (not psm.should_quit()):
        
        if len(plc_input_reg_names) != 0:
            get_input_from_sim() # to update PLC's input registers
            
        sleep(0.3) # To mantain consistency with the scan cycle

        if len(plc_output_reg_names) != 0:
            send_output_to_sim() # to update actuators values (sending these info to the simulator)

    psm.stop()
