#define PACKET_SIZE 270

struct Packet
{
    uint32_t authentication_cookie;
    uint8_t msg_type;
    uint8_t mflags;
    unsigned char h_source[ETH_ALEN];
    char buffer[PACKET_SIZE];
};

void parse_packet(char *, struct Packet &);