#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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

void create_board(unsigned int size, char ** board){
  int i = 0;
  for (i = 0; i < size; i++){
    board[i] = malloc(sizeof(int) * size);
    if (board[i] == NULL){
      printf("Board[%d] malloc error.", i);
      exit(1);
    }
  }
  printf("Each player should enter\na row and col num (eg: 2 0).\n");
}

void print_board(char * interlude_str, unsigned int size, char ** board){
  int row = 0;
  int col = 0;

  for (row = 0; row < size; row++){
    printf("%s\n", interlude_str);
    for (col = 0; col < size; col++){
      printf("| ");
      if (board[row][col] == 'O'){
	printf("O ");
      }
      else if (board[row][col] == 'X'){
	printf("X ");
      }
      else{
	printf("  ");
      }
    }
    printf("|\n");
  }

  printf("%s\n", interlude_str);
}

int check_win(unsigned int x, unsigned int y, char ** board, unsigned int boardLength, char compare){
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
  
  //Need to check row
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

int main(){
  unsigned int boardLength = 0;
  char output_play;
  int output;
  char ** board;
  unsigned int boardSize = 0;
  int playerOneTurn = 1;
  unsigned int x;
  unsigned int y;
  char * interlude_str;
  
  printf("Board Size (3..N):\n");
  scanf("%u", &boardLength);
  
  if (boardLength < 3){
    printf("Inappropriate value. Goodbye.\n");
    return 1;
  }

  interlude_str = malloc(sizeof(char) * (4 * boardLength + 2));
  if (interlude_str == NULL){
    printf("Malloc error for interlude_str.");
    exit(1);
  }
  init_interlude_str(interlude_str, boardLength);

  printf("Output Play (y/n):\n");
  scanf(" %c", &output_play);
  
  if (output_play == 'n'){
    output = 0;
  }
  else if (output_play == 'y'){
    output = 1;
  }
  else{
    printf("Inappropriate value. Goodbye.\n");
    return 1;
  }

  printf("You entered %u %c.\n", boardLength, output_play);
  printf("Starting game with %d x %d board.\n", boardLength, boardLength);

  board = malloc(sizeof(int*) * boardLength);
  if (board == NULL){
    printf("Board malloc error.");
    exit(1);
  }
  create_board(boardLength, board);

  while (boardSize < (boardLength * boardLength)){
    if (playerOneTurn){
      printf("Player 1:\n");
      scanf("%u %u", &x, &y);
      if (x >= boardLength && y >= boardLength){
        printf("Player 1 entered %u %u.\n", x, y);
	      // Error message
        printf("Inappropriate value. Goodbye.\n");
        return 1;
      }
      else if (x >= boardLength || y >= boardLength 
	      || board[x][y] == 'O' || board[x][y] == 'X'){
	      // Error message
        printf("Incorrect value, try again.\n");
        continue;
      }
      // Fill board; check if win
      else{
        printf("Player 1 entered %u %u.\n", x, y);
	      board[x][y] = 'O';
        if (output){
          print_board(interlude_str, boardLength, board);
        }
	      if (check_win(x, y, board, boardLength, 'O')){
	        // Print that they won
	        printf("Player 1 is the winner.\n");
	        break;
	      }
	      // Change whose turn it is
	      playerOneTurn = 0;
	      boardSize++;
      }
    }
    else{
      // Same thing but for player 2
      printf("Player 2:\n");
      scanf("%u %u", &x, &y);
      if (x >= boardLength && y >= boardLength){
        printf("Player 2 entered %u %u.\n", x, y);
	      // Error message
        printf("Inappropriate value. Goodbye.\n");
        return 1;
      }
      else if (x >= boardLength || y >= boardLength 
	      || board[x][y] == 'O' || board[x][y] == 'X'){
	      // Error message
        printf("Incorrect value, try again.\n");
        continue;
      }
      // Fill board; check if win
      else{
        printf("Player 2 entered %u %u.\n", x, y);
	      board[x][y] = 'X';
        if (output){
          print_board(interlude_str, boardLength, board);
        }
	      if (check_win(x, y, board, boardLength, 'X')){
	        // Print that they won
	        printf("Player 2 is the winner.\n");
	        break;
	      }
	      // Change whose turn it is
	      playerOneTurn = 1;
	      boardSize++;
      }
    }
  }

  if (boardSize == (boardLength * boardLength)){
    printf("Who wins?? Nobody!\n");
  }

  print_board(interlude_str, boardLength, board);

  // Free the row pointers of the board, then free the whole board
  int i = 0;
  for (i = 0; i < boardLength; i++){
    free(board[i]);
  }

  free(board);

  free(interlude_str);

  return 0;
}
