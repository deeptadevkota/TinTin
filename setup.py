from nest.experiment import *
from nest.topology import *
from nest.routing.routing_helper import RoutingHelper
import nest.config as config

from scapy.all import *

# TOPOLOGY
#
#               r2 ---- h2
#              /
#             /
#   h1 ---- r1
#             \
#              \
#               r3 ---- h3
#
####



class Setup:
    def __init__(self):
        pass
    def setup_topology(self):
        config.set_value("assign_random_names", False)
        config.set_value('delete_namespaces_on_termination', True)
        # config.set_value("routing_logs", True)


        # Create nodes

        # h = host
        self.h1 = Node("h1")
        self.h2 = Node("h2")
        self.h3 = Node("h3")
        # r = router
        self.r1 = Router("r1")
        self.r2 = Router("r2")
        self.r3 = Router("r3")
        self.nodes = [self.h1, self.h2, self.h3, self.r1, self.r2, self.r3]
        self.hostNodes = [self.h1, self.h2, self.h3]
        self.routerNodes = [self.r1, self.r2, self.r3]

        # Create interfaces
        (self.r1_h1, self.h1_r1) = connect(
            self.r1, self.h1, interface1_name="r1_h1", interface2_name="h1_r1"
        )
        (self.r2_h2, self.h2_r2) = connect(
            self.r2, self.h2, interface1_name="r2_h2", interface2_name="h2_r2"
        )
        (self.r3_h3, self.h3_r3) = connect(
            self.r3, self.h3, interface1_name="r3_h3", interface2_name="h3_r3"
        )
        (self.r1_r2, self.r2_r1) = connect(
            self.r1, self.r2, interface1_name="r1_r2", interface2_name="r2_r1"
        )
        (self.r1_r3, self.r3_r1) = connect(
            self.r1, self.r3, interface1_name="r1_r3", interface2_name="r3_r1"
        )

        # Set IPv4 Addresses
        self.h1_r1.set_address("10.0.1.2/24")
        self.r1_h1.set_address("10.0.1.1/24")
        self.h2_r2.set_address("10.0.2.2/24")
        self.r2_h2.set_address("10.0.2.1/24")
        self.h3_r3.set_address("10.0.3.2/24")
        self.r3_h3.set_address("10.0.3.1/24")
        self.r1_r2.set_address("10.0.4.1/24")
        self.r2_r1.set_address("10.0.4.2/24")
        self.r1_r3.set_address("10.0.5.1/24")
        self.r3_r1.set_address("10.0.5.2/24")

        RoutingHelper(protocol="rip").populate_routing_tables()
        
# time.sleep(300)    
setup_obj = Setup()
setup_obj.setup_topology()
setup_obj.h1.ping(setup_obj.h2_r2.address)
