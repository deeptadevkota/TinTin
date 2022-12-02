#include <linux/types.h>

struct newip_offset
{
    __u8 shipping_offset;
    __u8 contract_offset;
    __u8 payload_offset;
};

struct shipping_spec
{
    __u8 src_addr_type;
    __u8 dst_addr_type;
    __u8 addr_cast;
    // __u32 src_addr;
    // __u32 dst_addr;
};

struct src_addr{
    struct in6_addr v6_src_addr;
};

struct dst_addr{
    struct in6_addr v6_dst_addr;
};