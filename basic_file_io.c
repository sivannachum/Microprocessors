// Expects the name of a text file passed on the command line,
// copies the filename to a string on the stack.
//
// To compile and run:
//
// gcc gremlins.c -o gremlins
// ./gremlins someTextFile.txt
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main( int argc, char *argv[] ) {
  // Holds the name of the file from which we will be printing out chars
  char fileName[100];
  // This will be used as a char, but it needs to be an int to check for the EOF character
  int ch;
  FILE *filep;

  // display syntax if no arguments passed on command line
  if ( argc <= 1 ) {
    printf("Syntax: %s filename\n", argv[0] );
    exit(1);
  }

  // If the length of the argument is equal to 100 (or longer),
  // there's no space for the null character in fileName
  if (strlen(argv[1]) >= 100){
      printf("Filename %s is too long.\n", argv[1]);
      exit(1);
  }

  // if an argument is passed, it must be a file name
  strcpy( fileName, argv[1] );
  
  filep = fopen(fileName, "r");
  if (filep == NULL) {
    printf("Error: unable to open file %s\n", fileName);
    exit(1);
  }
  
  // Read the first character in the file
  ch = getc(filep);
  // As long as that character is not the end of file signifier:
  while (ch != EOF) {
    // If the character is 'g', we want to print out the word gremlin instead
    if (ch == 'g'){
      printf("%s", "gremlin");
    }
    // If the character is 'G', we want to print out the word GREMLIN instead
    else if (ch == 'G'){
      printf("%s", "GREMLIN");
    }
    // Otherwise, we just want to print out the character as is
    else{
      printf("%c", ch);    
    }
    // Get the next character in the file
    ch = getc(filep); 
  }
  
  // Close the file when we're done with it
  fclose(filep);

  return 0;
}
