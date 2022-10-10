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
#include "packet.h"
#include "new_ip.h"
#include "tintin.h"

void parse_packet(char *packet_str, struct Packet &packet)
{
    struct ethhdr *eth = (struct ethhdr *)(packet_str);
    packet.h_source[0] = eth->h_source[0];
    packet.h_source[1] = eth->h_source[1];
    packet.h_source[2] = eth->h_source[2];
    packet.h_source[3] = eth->h_source[3];
    packet.h_source[4] = eth->h_source[4];
    packet.h_source[5] = eth->h_source[5];

    struct TinTin *tintin = (struct TinTin *)(packet_str + sizeof(struct ethhdr) + sizeof(struct newip_offset) + sizeof(struct contract_offset));
    packet.authentication_cookie = tintin->auth_conn_cookie;
    packet.msg_type = tintin->msg_type;
    packet.mflags = tintin->mflags;

    return;
}