 
#include <stdio.h>
#include <stdlib.h>
#include <setjmp.h>


int main (int argc, char **argv) {        

        if (getenv("MY_VAR")) {

            if(argc == 3 && strcmp(argv[1], "-o") == 0 ) { 
                //redirect to file 
                if(!freopen(argv[2], "a+", stdout)) {
                    exit(1);
                }

                printf(" %s\n", getenv("MY_VAR"));

                if(!freopen("/dev/tty", "w", stdout)) {
                    exit(1);
                }
            } else {
                //print
                printf(" %s\n", getenv("MY_VAR"));
            }
        } else {
            //redirect to stderr
            fprintf(stderr, "No such env variable!\n");
            exit(123);
        }
   
}