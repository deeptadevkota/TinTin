#include <stdio.h>
#include <string.h>
#include <malloc.h>
#include <errno.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <netinet/if_ether.h>
#include <netinet/udp.h>
#include <linux/if_packet.h>
#include <arpa/inet.h>
#include <pthread.h>
#include "thread.h"

#define DESTMAC0 0xd0
#define DESTMAC1 0x67
#define DESTMAC2 0xe5
#define DESTMAC3 0x12
#define DESTMAC4 0x6f
#define DESTMAC5 0x8f

int sock_raw, n;
struct sockaddr_ll sadr_ll;

int thread_no = 0;
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
struct Thread *h_thread = NULL;
struct Thread *t_thread = NULL;
struct ifreq ifreq_c;

int main()
{
    sock_raw = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
    printf("%d\n", sock_raw);
    if (sock_raw < 0)
    {
        perror("error in socket\n");
        return -1;
    }

    // getting the the Interface index

    struct ifreq ifreq_i;
    memset(&ifreq_i, 0, sizeof(ifreq_i));
    strncpy(ifreq_i.ifr_name, "enp0s3", IFNAMSIZ - 1);
    if ((ioctl(sock_raw, SIOCGIFINDEX, &ifreq_i)) < 0)
        printf("error in index ioctl reading");

    // getting MAC Address

    memset(&ifreq_c, 0, sizeof(ifreq_c));
    strncpy(ifreq_c.ifr_name, "enp0s3", IFNAMSIZ - 1);
    if ((ioctl(sock_raw, SIOCGIFHWADDR, &ifreq_c)) < 0)
        printf("error in SIOCGIFHWADDR ioctl reading");

    // filling the socket address

    sadr_ll.sll_ifindex = ifreq_i.ifr_ifindex;
    sadr_ll.sll_halen = ETH_ALEN;
    sadr_ll.sll_family = AF_PACKET;

    // binding the raw socket to the interface

    if ((bind(sock_raw, (struct sockaddr *)&sadr_ll, sizeof(sadr_ll))) == -1)
    {
        perror("Error binding raw socket to interface\n");
        return -1;
    }

    // fresh_request sending
    struct Packet packet;
    packet.msg_type = 1;
    packet.mflags = 0;
    packet.authentication_cookie = 1; // ******* generate auth cookie *********
    packet.h_source[0] = DESTMAC0;
    packet.h_source[1] = DESTMAC1;
    packet.h_source[2] = DESTMAC2;
    packet.h_source[3] = DESTMAC3;
    packet.h_source[4] = DESTMAC4;
    packet.h_source[5] = DESTMAC5;

    make_packet_send(packet);
    printf("Fresh request sent!\n");
    int r = thread_insertion(packet.authentication_cookie);

    int rc = 0;
    pthread_t threads[MAX_THREADS];

    while (1)
    {
        struct Request *request = (struct Request *)malloc(sizeof(struct Request));

        n = recvfrom(sock_raw, request->buffer, PACKET_SIZE, 0, NULL, NULL);

        if (n < 0)
            perror("error in recvfrom");

        rc = pthread_create(&threads[thread_no], NULL, request_handling, (void *)request);
        if (rc)
        {
            perror("error in processing the request\n");
        }
        else
        {
            thread_no++;
        }
    }
    return 0;
}

// return authentication cookie
uint32_t gen_auth_cookie()
{
}