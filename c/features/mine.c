#include <stdio.h> // Part of the stdlib
//-------New-CHANGE------------//
#include <stdlib.h>
#include <time.h>
//----------------------------//

int x; // Columns
int y; // Rows

typedef struct tile_s { // tile structure
	int value;			// value of tiles
	int checked;		// if tile is selected
	int flaged;			// is tile flaged
} tile_t;				// create tile type

extern void drawBoard(int bx,int by,tile_t B[by][bx]);
//-------New-CHANGE------------//
extern int checkTile(tile_t*);
extern void revealtile(tile_t*);
extern void resetboard(int bx,int by,tile_t B[by][bx]);
extern void placemines(int bx,int by,tile_t B[by][bx]);
//----------------------------//
extern int* getPlayerInput(void);
//-------New-CHANGE------------//
extern int mapClear(int bx,int by,tile_t B[by][bx]);
extern void showAll(int bx,int by,tile_t B[by][bx]);
//----------------------------//

void drawBoard(int bx,int by,tile_t B[by][bx]){ // draw map
	// for each row and column
	for(int i = 0; i < by; i++){
		for(int j = 0; j < bx; j++){
			// append value to stdout
			//-------New-CHANGE------------//
			if (!B[i][j].checked) { // show as an x if not checked
				printf(" x,");
			}else{
				if (B[i][j].value < 0) {
					printf("%d,",B[i][j].value); 
				}else{
					printf(" %d,",B[i][j].value);
				}
			}
			//----------------------------//
		}
		// newline
		printf("\n");
	}
}

//-------New-CHANGE------------//
int checkTile(tile_t* t){
	if(t->value < 0){ return 1; }
	return 0;
}

void resetboard(int bx,int by,tile_t B[by][bx]){
	// for each row and column
	for(int i = 0; i < by; i++){
		for(int j = 0; j < bx; j++){
			// reset tile
			B[i][j] = (tile_t){0,0,0};
		}
	}
}

void placemines(int bx,int by,tile_t B[by][bx]){
	// for each row and column
	for(int i = 0; i < by; i++){
		for(int j = 0; j < bx; j++){
			// set bombs randomly
			if((rand() % 2) == 1){
				B[i][j] = (tile_t){-1,0,0};
			}
		}
	}
}

void revealtile(tile_t* t){
	t->checked = 1;
}

int mapClear(int bx,int by,tile_t B[by][bx]){
	int ret = 0;
	
	// for each row and column
	for(int i = 0; i < by; i++){
		for(int j = 0; j < bx; j++){
			if(!checkTile(&B[j][i])){
				if(!B[j][i].checked){
					// find all non bomb tiles to win
					ret = 1;
				}
			}
		}
	}
	
	return ret;
}

void showAll(int bx,int by,tile_t B[by][bx]){
	// for each row and column
	for(int i = 0; i < by; i++){
		for(int j = 0; j < bx; j++){
			B[j][i].checked = 1;
		}
	}
}
//----------------------------//

int main(int argc, char** argv){ // Starter function
	srand((0)); // update randomseed
	x = 7; // default
	y = 7;  // default
	tile_t map[y][x]; // create map
	//-------New-CHANGE------------//
	char sstr[9];
	int sx,sy; // select variables
	resetboard(x,y,map); // reset the board
	placemines(x,y,map); // place mines
	/* removed:
	// for each row and column
	for(int i = 0; i < y; i++){
		for(int j = 0; j < x; j++){
			// reset tile
			map[i][j] = (tile_t){0,0,0};
		}
	}
	*/
	// removed: printf("x:%d, y:%d\n",x,y);
	// removed: drawBoard(x,y,map); // draw the map
	
	do{
		printf("\n");
		drawBoard(x,y,map); // draw the map
		
		// get player input
		printf("enter tile x: ");		// input text for x
		fgets(sstr, 9, stdin);			// read stdin into sstr
		sx = strtol(sstr,NULL,0) - 1;	// get x from sstr
		printf("enter tile y: ");		// input text for y
		fgets(sstr, 9, stdin);			// read stdin into sstr
		sy = strtol(sstr,NULL,0) - 1;	// get y from sstr
		
		if(checkTile(&map[sy][sx])){
			// if tile is a bomb
			printf("\nTHAT'S A BOMB\n");
			printf("GAME OVER\n");	// loser XD
			goto end;				// goto the end
		}
		
		revealtile(&map[sy][sx]); // show the tile
		
	}while(mapClear(x,y,map)); // while the map is not clear
	printf("\nYOU WIN\n"); // winner :D
	
	end:
	showAll(x,y,map);	// show the map
	drawBoard(x,y,map);	// draw the map
	//----------------------------//
	return 0; // Zero Errors
}
