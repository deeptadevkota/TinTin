all: client.o thread.o packet.o
	g++ client.o thread.o packet.o -lpthread -o client
packet.o:
	g++ -c packet.c -o packet.o
thread.o: packet.o
	g++ -c thread.c -o thread.o
client.o: thread.o packet.o
	g++ -lpthread -c client.c -o client.o