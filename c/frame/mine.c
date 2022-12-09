#include <stdio.h> // Part of the stdlib

int x; // Columns
int y; // Rows

typedef struct tile_s { // tile structure
	int value;			// value of tiles
	int checked;		// if tile is selected
	int flaged;			// is tile flaged
} tile_t;				// create tile type

extern void drawBoard(int bx,int by,tile_t B[by][bx]);
extern int* getPlayerInput(void);
extern int checkTile(void);
extern int mapClear(void);

void drawBoard(int bx,int by,tile_t B[by][bx]){ // draw map
	// for each row and column
	for(int i = 0; i < by; i++){
		for(int j = 0; j < bx; j++){
			// append value to stdout
			printf("%d,",B[i][j].value);
		}
		// newline
		printf("\n");
	}
}

int main(int argc, char** argv){ // Starter function
	x = 7; // default
	y = 7;  // default
	tile_t map[y][x]; // create map
	
	// for each row and column
	for(int i = 0; i < y; i++){
		for(int j = 0; j < x; j++){
			// reset tile
			map[i][j] = (tile_t){0,0,0};
		}
	}
	printf("x:%d, y:%d\n",x,y);
	drawBoard(x,y,map); // draw the map
	
	return 0; // Zero Errors
}
