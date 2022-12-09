#include <stdio.h> // Part of the stdlib
#include <stdlib.h>
#include <time.h>

#define _BLKBTC "\e[48;2;20;20;20m"
#define _WHTHBTC "\e[48;2;255;255;255m"
#define _REDBTC "\e[48;2;255;160;122m"
#define _GRNBTC "\e[48;2;198;255;227m"
#define _YELBTC "\e[48;2;241;255;103m"
#define _BLUBTC "\e[48;2;112;151;176m"
#define _LBLUBTC "\e[48;2;133;132;205m"
#define _MAGBTC "\e[48;2;250;165;255m"
#define _CYNBTC "\e[48;2;162;211;242m"
#define _GRYBTC "\e[48;2;204;204;204m"
#define _ORNBTC "\e[48;2;252;219;129m"
#define _reset "\e[0m"

int x; // Columns
int y; // Rows

typedef struct tile_s { // tile structure
	int value;			// value of tiles
	int checked;		// if tile is selected
	int flaged;			// is tile flaged
} tile_t;				// create tile type

extern void drawBoard(int bx,int by,tile_t B[by][bx]);
extern int checkTile(tile_t*);
extern void revealtile(tile_t*);
extern void resetboard(int bx,int by,tile_t B[by][bx]);
extern void placemines(int bx,int by,tile_t B[by][bx]);
extern int* getPlayerInput(void);
extern int mapClear(int bx,int by,tile_t B[by][bx]);
extern void showAll(int bx,int by,tile_t B[by][bx]);
extern char* getcolour(int);
extern void drawRow(int bx,int by,tile_t B[by][bx]);
extern int checkneighbors(int,int,int bx,int by,tile_t B[by][bx]);
extern void updateTiles(int bx,int by,tile_t B[by][bx]);

void drawBoard(int bx,int by,tile_t B[by][bx]){ // draw map
	// for each row and column
	for(int i = 0; i < by; i++){
		for(int j = 0; j < bx; j++){
			// append value to stdout
			if (!B[i][j].checked) { // show as an x if not checked
				printf(" x,");
			}else{
				if (B[i][j].value < 0) {
					printf("%d,",B[i][j].value); 
				}else{
					printf(" %d,",B[i][j].value);
				}
			}
		}
		// newline
		printf("\n");
	}
}

int checkneighbors(int ix,int iy,int bx,int by,tile_t B[by][bx]){
	if(checkTile(&B[iy][ix])){ return -1; }	// bomb guard
	int ret = 0;
	if(ix + 1 < bx){
		ret = ret + checkTile(&B[iy][ix + 1]);
		if(iy + 1 < by){
			ret = ret + checkTile(&B[iy + 1][ix + 1]);
		}
		if(iy - 1 > -1){
			ret = ret + checkTile(&B[iy - 1][ix + 1]);
		}
	}
	if(ix - 1 > -1){
		ret = ret + checkTile(&B[iy][ix - 1]);
		if(iy + 1 < by){
			ret = ret + checkTile(&B[iy + 1][ix - 1]);
		}
		if(iy - 1 > -1){
			ret = ret + checkTile(&B[iy - 1][ix - 1]);
		}
	}
	if(iy + 1 < by){
		ret = ret + checkTile(&B[iy + 1][ix]);
	}
	if(iy - 1 > -1){
		ret = ret + checkTile(&B[iy - 1][ix]);
	}
	
	return ret;
}

void updateTiles(int bx,int by,tile_t B[by][bx]){
	for(int i = 0; i < by; i++){
		for(int j = 0; j < bx; j++){
			B[i][j].value = checkneighbors(j,i,bx,by,B);
		}
	}
}

char* getcolour(int c){
	switch (c) {
		case -1:
			return _REDBTC;
		case 0:
			return _CYNBTC;
		case 1:
			return _BLKBTC;
		case 2:
			return _BLUBTC;
		case 3:
			return _LBLUBTC;
		case 4:
			return _MAGBTC;
		case 5:
			return _YELBTC;
		case 6:
			return _GRYBTC;
		case 7:
			return _CYNBTC;
		case 8:
			return _WHTHBTC;
		default:
			return _WHTHBTC;
	}
}

void drawRow(int bx,int by,tile_t B[by][bx]){
	// for each row and column
	for(int i = 0; i < by; i++){
		for(int j = 0; j < bx; j++){
			// append value to stdout
			if (!B[i][j].checked) { // show as an x if not checked
				printf("%s  x  %s",_CYNBTC,_reset);
			}else{
				if (B[i][j].value < 0) {
					printf("%s %d  %s",getcolour(B[i][j].value),B[i][j].value,_reset); 
				}else{
					printf("%s  %d  %s",getcolour(B[i][j].value),B[i][j].value,_reset);
				}
			}
		}
		// newline
		printf("\n");
	}
}

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

int main(int argc, char** argv){ // Starter function
	srand(time(0)); // update randomseed
	x = 7; // default
	y = 7;  // default
	tile_t map[y][x]; // create map
	char sstr[9];
	int sx,sy; // select variables
	resetboard(x,y,map); // reset the board
	placemines(x,y,map); // place mines
	updateTiles(x,y,map); // update tiles
	
	do{
		printf("\n");
		drawRow(x,y,map); // draw the map
		
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
	drawRow(x,y,map); // draw the map
	return 0; // Zero Errors
}
