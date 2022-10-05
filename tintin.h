typedef struct _tintin_hdr
{
    uint8_t next_proto;
    uint8_t hdr_len;
    uint8_t control_w; // any-flags
    uint8_t msg_type;
    uint32_t auth_conn_cookie;
} tintin_hdr;

typedef enum msg_types
{
    FRESH = 1, // Authorize
    REFRESH = 2,
    ASYNC = 3,
    SYNC = 4,
    PUSH = 5,
} MSGS;

typedef struct _freshpdu_
{
    uint8_t mlen;
    uint8_t mtype; // flags = 0, INIT, GRANT, DENIED.
    uint16_t magic;
    int private_cert;
} freshpdu_t;

typedef freshpdu_t freshverify_pdu_t;

typedef struct _async_msg
{
    uint8_t mlen;
    uint8_t mflags;
    uint16_t epoch;

} asyncmsg_t;

typedef struct _asyncreply_msg
{
    uint8_t mlen;
    uint8_t mflags;
    uint16_t epoch;
    uint32_t reason;

} asyncreply_t;

typedef struct _tintin_pdu_
{
    tintin_hdr hdr;
    union
    {
        freshpdu_t fresh;
        freshverify_pdu_t verify;
        asyncmsg_t async;
        asyncreply_t async_reply;
    } msgpdu;
} tintin_pdu;