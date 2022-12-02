struct __attribute__((__packed__)) TinTin
{
    uint16_t contract_type;
    uint16_t next_proto;
    uint16_t hdr_len;
    uint16_t control_w;
    uint16_t msg_type;
    uint16_t mlen;
    uint16_t mflags;
    uint16_t magic;
    uint32_t auth_conn_cookie;
};



typedef enum msg_types
{
    FRESH = 1, // Authorize
    REFRESH = 2,
    ASYNC = 3,
    SYNC = 4,
    PUSH = 5,
} MSGS;