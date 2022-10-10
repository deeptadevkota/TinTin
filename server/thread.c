#include "thread.h"
#include "packet.h"

extern pthread_mutex_t mutex;

void *request_handling(void *request)
{
    struct Request *request = (Request *)req;
    char packet_str[PACKET_SIZE];
    strcpy(packet_str, request->buf);

    struct Packet packet;
    parse_packet(packet_str, packet);

    
}

bool thread_insertion(uint32_t auth_id)
{
}

bool thread_removal(uint32_t auth_id)
{
}
