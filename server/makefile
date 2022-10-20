all: server.o packet.o thread.o
		g++ server.o packet.o thread.o -o server
server.o:
		g++ -c server.c -o server.o
packet.o:
		g++ packet.c -o packet.o
thread.o:
		g++ thread.c -o thread.o