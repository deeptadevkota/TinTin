#include <iostream>
#include <sys/types.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <time.h>
#include <netinet/in.h>
#include <string.h>
#include <netdb.h>
#include <stdio.h>
#include <pthread.h>
#include <linux/if_packet.h>
#include <net/if.h>
#include "thread.h"
#include "new_ip.h"
#include "tintin.h"

#define DESTMAC0 0x6a
#define DESTMAC1 0x19
#define DESTMAC2 0x56
#define DESTMAC3 0x02
#define DESTMAC4 0x00
#define DESTMAC5 0x63

extern int sock_raw, n;
extern struct sockaddr_ll sadr_ll;

extern int thread_no;
extern pthread_mutex_t mutex;
extern struct Thread *h_thread;
extern struct Thread *t_thread;
extern struct ifreq ifreq_c;

void *request_handling(void *req)
{
    struct Request *request = (struct Request *)req;
    struct Packet packet = parse_packet(request->buffer);
    // printf("type %d, flag %d\n", packet.msg_type, packet.mflags);
    // fresh response
    if (packet.msg_type == 1 && packet.mflags == 1)
    {

        int r = thread_exist(packet.authentication_cookie);
        if (r != 1)
        {
            // printf("0\n");
        }
        else
        {
            printf("Fresh Response Received. type: %d, flag: %d\n", packet.msg_type, packet.mflags);

            printf("Sending Async Request\n");
            // async_request sending
            struct Packet packet1;
            packet1.msg_type = 3;
            packet1.mflags = 0;
            packet1.authentication_cookie = packet.authentication_cookie;
            char buf[18];
            FILE *fp = fopen("../h1_r1_mac.txt", "r");
            fscanf(fp, "%s", buf);
            // should be filled with the server MAC address
            char tempbuf[3];
            int count = 0;
            for(int i=0; i<18; i+=3){
                tempbuf[0] = buf[i];
                tempbuf[1] = buf[i+1];
                tempbuf[2] = 0;
                packet.h_source[count] = strtol(tempbuf, NULL, 16);
                printf("%c:", packet.h_source[count]);
                count++;
            }

            make_packet_send(packet1);
            // printf("2\n");
        }
    }
    // if async response
    else if (packet.msg_type == 3 && packet.mflags == 1)
    {
        // printf("3\n");
        printf("Async response Received, type: %d, flag: %d. \n", packet.msg_type, packet.mflags);
        int r = thread_exist(packet.authentication_cookie);
        if (r != 1)
        {
            printf("0\n");
        }
    }
}

int thread_insertion(uint32_t authentication_cookie)
{
    struct Thread *new_thread = (struct Thread *)malloc(sizeof(struct Thread));

    new_thread->auth_conn_cookie = authentication_cookie;
    if (h_thread == NULL && t_thread == NULL)
    {
        new_thread->prev_thread = NULL;
        new_thread->next_thread = NULL;
        h_thread = new_thread;
        t_thread = new_thread;
    }
    else
    {
        t_thread->next_thread = new_thread;
        new_thread->prev_thread = t_thread;
        new_thread->next_thread = NULL;
        t_thread = new_thread;
    }
}

int thread_exist(uint32_t auth_id)
{
    struct Thread *head = h_thread;
    while (head)
    {

        if (head->auth_conn_cookie == auth_id)
            return 1;

        head = head->next_thread;
    }
    return 0;
}

void make_packet_send(struct Packet packet)
{
    unsigned char *sendbuff = (unsigned char *)malloc(PACKET_SIZE); // increase in case of more data
    memset(sendbuff, 0, PACKET_SIZE);
    struct ethhdr *eth = (struct ethhdr *)(sendbuff);
    eth->h_source[0] = (unsigned char)(ifreq_c.ifr_hwaddr.sa_data[0]);
    eth->h_source[1] = (unsigned char)(ifreq_c.ifr_hwaddr.sa_data[1]);
    eth->h_source[2] = (unsigned char)(ifreq_c.ifr_hwaddr.sa_data[2]);
    eth->h_source[3] = (unsigned char)(ifreq_c.ifr_hwaddr.sa_data[3]);
    eth->h_source[4] = (unsigned char)(ifreq_c.ifr_hwaddr.sa_data[4]);
    eth->h_source[5] = (unsigned char)(ifreq_c.ifr_hwaddr.sa_data[5]);
    eth->h_dest[0] = packet.h_source[0];
    eth->h_dest[1] = packet.h_source[1];
    eth->h_dest[2] = packet.h_source[2];
    eth->h_dest[3] = packet.h_source[3];
    eth->h_dest[4] = packet.h_source[4];
    eth->h_dest[5] = packet.h_source[5];

    eth->h_proto = htons(0x88b6);
    printf("%d\n",eth->h_proto);
    int total_len = 0;
    total_len += sizeof(struct ethhdr);

    struct newip_offset *newip_offset_val;
    newip_offset_val = (struct newip_offset *)(sendbuff + sizeof(struct ethhdr));
    newip_offset_val->shipping_offset = sizeof(struct newip_offset);
    newip_offset_val->contract_offset = (__uint8_t)(sizeof(struct newip_offset) + sizeof(struct shipping_spec));
    newip_offset_val->payload_offset = (__uint8_t)(sizeof(struct newip_offset) + sizeof(struct shipping_spec) + sizeof(struct TinTin));
    printf("size of shipping spec%x\n", sizeof(struct shipping_spec));
    printf("contract offset:%x\n", newip_offset_val->contract_offset);
    printf("payload offset:%x\n", newip_offset_val->payload_offset);

    total_len += sizeof(struct newip_offset);

    struct shipping_spec *shipping_spec_val;
    shipping_spec_val = (struct shipping_spec *)(sendbuff + sizeof(struct ethhdr) + sizeof(struct newip_offset));
    shipping_spec_val->src_addr_type = 0;
    shipping_spec_val->dst_addr_type = 0;
    shipping_spec_val->addr_cast = 0;
    shipping_spec_val->src_addr = htonl(0x0a000002);
    shipping_spec_val->dst_addr = htonl(0x0a000102);
    total_len += sizeof(struct shipping_spec);

    struct TinTin *tintin = (struct TinTin *)(sendbuff + sizeof(struct ethhdr) + sizeof(struct newip_offset) + sizeof(struct shipping_spec));
    tintin->contract_type = htons(4);
    tintin->next_proto = htons(1);
    tintin->hdr_len = htons(2);
    tintin->control_w = htons(3);
    tintin->msg_type = htons(packet.msg_type);
    tintin->auth_conn_cookie = packet.authentication_cookie;
    tintin->mlen = htons(6);
    tintin->mflags = htons(packet.mflags);
    tintin->magic = htons(8);

    total_len = PACKET_SIZE;

    int send_len = sendto(sock_raw, sendbuff, total_len, 0, (const struct sockaddr *)&sadr_ll, sizeof(struct sockaddr_ll));
    if (send_len < 0)
    {
        printf("error in sending....");
    }
}
