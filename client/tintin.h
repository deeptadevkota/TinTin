struct TinTin
{
    uint8_t next_proto;
    uint8_t hdr_len;
    uint8_t control_w;
    uint8_t msg_type;
    uint32_t auth_conn_cookie;
    uint8_t mlen;
    uint8_t mflags;
    uint16_t magic;
};



typedef enum msg_types
{
    FRESH = 1, // Authorize
    REFRESH = 2,
    ASYNC = 3,
    SYNC = 4,
    PUSH = 5,
} MSGS;