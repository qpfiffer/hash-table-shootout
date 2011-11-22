#include <sys/time.h>
#include <sys/types.h>
#include <time.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <math.h>

double get_time(void)
{
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return tv.tv_sec + (tv.tv_usec / 1000000.0);
}

int main(int argc, char ** argv)
{
    int num_keys = atoi(argv[1]);
    int interval = atoi(argv[2]);
    int i, value = 0;

    if(argc <= 2)
        return 1;

    SETUP

    double last    = get_time();
    double current = get_time();
    double diff = 0;

    srandom(1); // for a fair/deterministic comparison
    for(i = 1; i < (num_keys + 1); i++)
    {
        INSERT_INT_INTO_HASH((int)random(), value);
        if(i % interval == 0) {
            current = get_time();
            diff    = current - last;
            last    = current;
            printf("%f\n",diff);
        }
    }

    fflush(stdout);
    sleep(1000000);
}
