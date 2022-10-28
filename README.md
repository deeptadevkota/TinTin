Description
-----------

The project contains a server and a client which communicate using TinTin protocol. 

Instructions for USE:
---------------------

NAMESPACES:
1. Emulate the network by running the bash file using sudo privileges.
```
$ ./ns.sh
```

SERVER:
1. The folder server makes a complete and independent 'server' which communicates with a client
2. cd to the folder 'server':
```
$ cd server
```
3. Run the make command
```
$ make
```
4. Run the executable 'server' in the server namespace
```
$ sudo ip netns exec server ./server
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
$ make
```
4. Run the executable 'client' in the client namespace
```
$ sudo ip netns exec client ./client
```
5. The client will now establish connection with the server.

