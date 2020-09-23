#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/**
* Initialize the interlude string ------ that appears between rows of the tic tac toe board.
* interlude_str: the malloced space that will hold the interlude string
* size: the number of rows in the tic tac toe board
*/
void init_interlude_str(char* interlude_str, unsigned int size){
  int i = 0;
  int j = 0;
  strcpy(interlude_str, "-");

  for (i = 0; i < 4; i++){
    for (j = 0; j < size; j++){
      strcat(interlude_str, "-");
    }
  }
}

/**
* Initialize the row pointers of the size x size board matrix.
* size: the number of rows (which equals the number of columns) in the tic tac toe board
* board: the address of the tic tac toe board row pointers in memory
*/
void create_board(unsigned int size, char ** board){
  int i = 0;
  int row = 0;
  int col = 0;
	
  for (i = 0; i < size; i++){
    board[i] = malloc(sizeof(int) * size);
    if (board[i] == NULL){
      printf("Board[%d] malloc error.", i);
      exit(1);
    }
  }
  
  // Juse make sure that none of the tic tac toe places are preset to 'X' or 'O' due to previous use of this memory.
  for (row = 0; row < size; row++){
    for (col = 0; col < size; col++){
      board[row][col] = ' ';
    }
  }
  printf("Each player should enter\na row and col num (eg: 2 0).\n");
}

/**
* Print out what the tic tac toe board looks like.
* interlude_str: the interlude string ----- to print between rows of the tic tac toe board
* size: the number of rows in the tic tac toe board
* board: the address of the tic tac toe board row pointers in memory
*/
void print_board(char* interlude_str, unsigned int size, char ** board){
  int row = 0;
  int col = 0;

  for (row = 0; row < size; row++){
    printf("%s\n", interlude_str);
    for (col = 0; col < size; col++){
      printf("| %c ", board[row][col]);
	// CHANGED    
  /*
      if (board[row][col] == 'O'){
	printf("O ");
      }
      else if (board[row][col] == 'X'){
	printf("X ");
      }
      else{
	printf("  ");
      }
     */
    }
    printf("|\n");
  }

  printf("%s\n", interlude_str);
}

/**
* Check if the latest game move results in a win.
* x: the row of the latest input
* y: the column of the latest input
* board: the tic tac toe board
* boardLength: the number of rows (which is equal to the number of columns) in the tic tac toe board
* player: which player's turn it is
*/
int check_win(unsigned int x, unsigned int y, char ** board, unsigned int boardLength, int player){
  char compare;
  if (player == 1){
    compare = 'O';
  }
  else{
    compare = 'X';
  }
  // Used as a boolean to determine a win or not
  int win = 0;
  int i = 0;
  
  // Need to check diagonal starting at top left
  if (x == y){
    win = 1;
    for (i = 0; i < boardLength; i++){
      if (board[i][i] != compare){
	win = 0;
	break;
      }
    }
    if (win){
      return win;
    }
  }
  
  // Need to check diagonal starting at top right
  if (x + y == boardLength - 1){
    win = 1;
    for (i = 0; i < boardLength; i++){
      if (board[i][boardLength-1-i] != compare){
	win = 0;
	break;
      }
    }
    if (win){
      return win;
    }
  }
  
  // Need to check row
  win = 1;
  for (i = 0; i < boardLength; i++){
    if (board[i][y] != compare){
      win = 0;
      break;
    }
  }
  
  if (win){
    return win;
  }
  
  // Need to check column
  win = 1;
  for (i = 0; i < boardLength; i++){
    if (board[x][i] != compare){
      win = 0;
      break;
    }
  } 
  return win;
}

/**
* Runs the program / the game.
*/
int main(){
  // The number of rows (which equals the number of columns) in the tic tac toe board
  unsigned int boardLength = 0;
  // Holds the y/n answer of the user to whether or not they want the output of the board during gameplay
  char output_play;
  // Boolean to keep track of whether or not the user wants output of the board during gameplay
  int output;
  // The matrix that holds the tic tac toe board
  char ** board;
  // How many spaces in the board have been filled by players
  unsigned int boardSize = 0;
  // Keeps track of whose turn it is
  int player = 1;
  // Variables to hold the values input by users as they play
  unsigned int x;
  unsigned int y;
  // The interlude string ----- printed between rows of the tic tac toe board when it is output to the screen
  char * interlude_str;
  
  // Ask the user what size board they want
  printf("Board Size (3..N):\n");
  scanf("%u", &boardLength);
  
  // If they put in an inappropriate value, quit
  if (boardLength < 3){
    printf("Inappropriate value. Goodbye.\n");
    return 1;
  }

  // Malloc the interlude string space, with enough space for the null terminator!
  // Then initialize the string's value
  interlude_str = malloc(sizeof(char) * (4 * boardLength + 2));
  if (interlude_str == NULL){
    printf("Malloc error for interlude_str.");
    exit(1);
  }
  init_interlude_str(interlude_str, boardLength);

  // Ask the user if they want output of the play
  printf("Output Play (y/n):\n");
  scanf(" %c", &output_play);
  
  if (output_play == 'n'){
    output = 0;
  }
  else if (output_play == 'y'){
    output = 1;
  }
  // If they put in an inappropriate value, quit
  else{
    printf("Inappropriate value. Goodbye.\n");
    return 1;
  }

  // Tell the user what they entered and that you're starting the game
  printf("You entered %u %c.\n", boardLength, output_play);
  printf("Starting game with %d x %d board.\n", boardLength, boardLength);

  // Malloc the space in the board for the row pointers
  board = malloc(sizeof(int*) * boardLength);
  if (board == NULL){
    printf("Board malloc error.");
    exit(1);
  }
  // Malloc the row spaces
  create_board(boardLength, board);

  // Gameplay while loop
  while (boardSize < (boardLength * boardLength)){
    printf("Player %d:\n", player);
    scanf("%u %u", &x, &y);
    // If they input a completely inappropriate value, quit
    if (x >= boardLength && y >= boardLength){
      printf("Player %d entered %u %u.\n", player, x, y);
      // Error message
      printf("Inappropriate value. Goodbye.\n");
      return 1;
    }
    // If they only input a partially inappropriate value, tell them to try again
    else if (x >= boardLength || y >= boardLength 
	    || board[x][y] == 'O' || board[x][y] == 'X'){
      // Error message
      printf("Incorrect value, try again.\n");
      continue;
    }
    // Fill board; check if win
    else{
      printf("Player %d entered %u %u.\n", player, x, y);
      if (player == 1){
        board[x][y] = 'O';
      }
      else {
        board[x][y] = 'X';
      }
      // If they want board output, output it
      if (output){
        print_board(interlude_str, boardLength, board);
      }
      if (check_win(x, y, board, boardLength, player)){
	// Print that they won
	printf("Player %d is the winner.\n", player);
	break;
      }
      // Change whose turn it is and keep track of the board size
      if (player == 1){
	player = 2;
      }
      else{
        player = 1;
      }
      boardSize++;
    }
  }

  // If they filled the whole board without anybody winning
  if (boardSize == (boardLength * boardLength)){
    printf("Who wins?? Nobody!\n");
  }

  // Print the board at the end of the game
  print_board(interlude_str, boardLength, board);

  // Free the row pointers of the board, then free the whole board
  int i = 0;
  for (i = 0; i < boardLength; i++){
    free(board[i]);
    board[i] = NULL;
  }

  free(board);
  board = NULL;

  free(interlude_str);
  interlude_str = NULL;

  return 0;
}
