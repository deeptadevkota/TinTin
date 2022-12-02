import os
import time
from nest.topology import *
import subprocess
import nest.config as config
from nest.routing.routing_helper import RoutingHelper
from nest.engine import exec_subprocess

config.set_value("assign_random_names", False)
config.set_value("delete_namespaces_on_termination", True)
config.set_value("routing_suite", "frr")

client = Node("h1")
server = Node("h2")
router = Router("r1")

(r1_h1, h1_r1) = connect(router, client, interface1_name="r1_h1", interface2_name="h1_r1")
(r1_h2, h2_r1) = connect(router, server, interface1_name="r1_h2", interface2_name="h2_r1")

# Set IPv4 Addresses
h1_r1.add_address("10.0.0.2/24")
r1_h1.add_address("10.0.0.1/24")
h2_r1.add_address("10.0.1.2/24")
r1_h2.add_address("10.0.1.1/24")

RoutingHelper(protocol="rip").populate_routing_tables()

# Set IPv6 Addresses
h1_r1.add_address("10::0:2/122")
r1_h1.add_address("10::0:1/122")
h2_r1.add_address("10::1:2/122")
r1_h2.add_address("10::1:1/122")
RoutingHelper(protocol="rip", ipv6_routing=True).populate_routing_tables()

client.add_route("DEFAULT", h1_r1, "10::0:1/122")  
server.add_route("DEFAULT", h2_r1, "10::1:1/122")



with router:
    rtg_path = os.path.join("/run", "frr")
    exists = os.path.exists(rtg_path)
    if exists:
        print("[INFO] : Routing suite is set with", "frr")
        exit

    # this can be a silent error. next cmd will also fail
    os.system('mkdir "' + rtg_path + '"')

        # os.chdir("/home/vanessa/TinTin/xdp/newip_router")
        # dir_name = "run/frr"
        # subprocess.run(["mkdir", dir_name], check =True, text=True)
    
    subprocess.run(["xdp/newip_router/xdp_loader", "--quiet", "--progsec", "xdp_router", "--filename", "xdp/newip_router/xdp_prog_kern.o", "--dev", "r1_h1"])
    print("1")
    subprocess.run(["xdp/newip_router/xdp_prog_user", "--quiet", "--filename","1_r1_h1-2_r1_h2-", "-d", "r1_h1"])
    print("2")
    subprocess.run(["tc", "qdisc", "add", "dev","r1_h1","ingress"])
    print("3")
    subprocess.run(["tc", "filter", "add" ,"dev", "r1_h1", "ingress", "bpf", "da", "obj", "xdp/newip_router/tc_prog_kern.o","sec", "tc_router"])
    print("4")
    subprocess.run(["tc","qdisc", "replace", "dev", "r1_h1","root" ,"lbf"])
    print("5")
    subprocess.run(["xdp/newip_router/xdp_loader", "--quiet", "--progsec", "xdp_router", "--filename", "xdp/newip_router/xdp_prog_kern.o", "--dev", "r1_h2"])
    print("6")
    subprocess.run(["xdp/newip_router/xdp_prog_user", "--quiet", "--filename","1_r1_h2-2_r1_h1-", "-d", "r1_h2"])
    print("7")
    subprocess.run(["tc", "qdisc", "add", "dev","r1_h2","ingress"])
    print("8")
    subprocess.run(["tc", "filter", "add" ,"dev", "r1_h2", "ingress", "bpf", "da", "obj", "xdp/newip_router/tc_prog_kern.o","sec", "tc_router"])
    print("9")
    subprocess.run(["tc","qdisc", "replace", "dev", "r1_h2","root","lbf"])
    print("10")



# time.sleep(3000)

get_neighbor = f"ip -4 -n h1 neigh show default dev h1_r1"
value = exec_subprocess(get_neighbor, output=True)
dst_mac = value.split()[2]
with open('h1_r1_mac.txt', 'w') as f:
    f.write(dst_mac)

get_neighbor = f"ip -4 -n h2 neigh show default dev h2_r1"
value = exec_subprocess(get_neighbor, output=True)
dst_mac = value.split()[2]
with open('h2_r1_mac.txt', 'w') as f:
    f.write(dst_mac)
time.sleep(3000)