#include <iostream>
#include <sys/types.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <time.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>
#include <netdb.h>
#include <stdio.h>
#include <pthread.h>
#include "packet.h"



#define MAX_THREADS 20000

struct Request
{
    char buffer[PACKET_SIZE];
};

struct Thread
{
    uint32_t auth_conn_cookie;
    struct Thread *prev_thread;
    struct Thread *next_thread;
};



void *request_handling(void *);
int thread_insertion(uint32_t);
int thread_removal(uint32_t);
void make_packet_send(struct Packet);