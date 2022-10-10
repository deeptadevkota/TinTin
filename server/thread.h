#define MAX_THREADS 20000
#define PACK_SIZE 270

struct Thread
{
    uint32_t auth_conn_cookie;
    unsigned char h_source[ETH_ALEN]; 
    struct Thread *next_thread;
};

struct Request
{
    char buffer[PACK_SIZE];
};

void *request_handling(void *);
bool thread_insertion(uint32_t);
bool thread_removal(uint32_t);