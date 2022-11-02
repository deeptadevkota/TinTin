ip netns add client
ip netns add server
ip link add eth0 type veth peer name eth1
ip link set eth0 netns client
ip link set eth1 netns server
ip -n client link set eth0 up
ip -n server link set eth1 up
ip -n client link set lo up
ip -n server link set lo up

# ip netns exec server ./server
# ip netns exec client ./client
