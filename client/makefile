all: client.o packet.o thread.o
		g++ client.o packet.o thread.o -o client
client.o:
		g++ -c client.c -o client.o
packet.o:
		g++ packet.c -o packet.o
thread.o:
		g++ thread.c -o thread.o