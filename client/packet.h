#include <iostream>
#include <sys/types.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>
#include <netdb.h>
#include <stdio.h>
#include <pthread.h>
#include <netinet/if_ether.h>

#define PACKET_SIZE 270
#define BUFFER_SIZE 256

struct Packet
{
    uint32_t authentication_cookie;
    uint8_t msg_type;
    uint8_t mflags;
    unsigned char h_source[ETH_ALEN];
    char buffer[BUFFER_SIZE];
};

struct Packet parse_packet(char *);