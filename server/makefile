all: server.o thread.o packet.o
	g++ server.o thread.o packet.o -lpthread -o server
packet.o:
	g++ -c packet.c -o packet.o
thread.o: packet.o
	g++ -c thread.c -o thread.o
server.o: thread.o packet.o
	g++ -lpthread -c server.c -o server.o