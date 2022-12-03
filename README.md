Description
-----------

The project contains a server and a client which communicate using TinTin protocol. 

Topology:
---------------------
```
 |client| <----> |router| <----> |server|
```
Instructions for USE:
---------------------

NAMESPACES:
1. Emulate the network by running the bash file using sudo privileges.
```
$ sudo python3 setup2.py
```
INSTALL LBF MODULES:
```
$ cd lbf
```
```
$ sudo ./install-modules
```
```
$ sudo ./install-tc-support
```
```
$ cd ..
```
SERVER:
1. The folder server makes a complete and independent 'server' which communicates with a client
2. cd to the folder 'server':
```
$ cd server
```
3. Run the make command
```
$ rm -f *.o
```
```
$ make
```
4. Run the executable 'server' in the h2 namespace
```
$ sudo ip netns exec h2 ./server
```
5. The Server has started listening
	
CLIENT:
1. The folder client makes a complete and independent 'client' which communicates with the specified server 
2. cd to the folder 'client'
```
$ cd client
```
3. Run the make command
```
$ rm -f *.o
```
```
$ make
```
4. Run the executable 'client' in the h1 namespace
```
$ sudo ip netns exec h1 ./client
```
5. The client will now establish connection with the server.

