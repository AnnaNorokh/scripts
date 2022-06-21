 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int main (int argc, char **argv) {        

        if (getenv("MY_VAR")) {

            if(argc == 3 && strcmp(argv[1], "-o") == 0 ) { 
                //redirect to file 
                                 
                FILE* file = fopen(argv[2], "w+");
                if (file == NULL) {
                    exit(1);
                }

                fprintf(file," %s\n", getenv("MY_VAR"));
                fclose(file);
            
            } else if (argc == 1 ) {
                //print
                printf("%s\n", getenv("MY_VAR"));
            } else {
                printf("%s\n", "Wrong arguments was supplied");
            }        
            } else {
            //redirect to stderr
            fprintf(stderr, "No such env variable!\n");
            exit(123);
        }
    
}
