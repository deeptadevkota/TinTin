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
};