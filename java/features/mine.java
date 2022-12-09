//-------New-CHANGE------------//
import java.util.Scanner;
//----------------------------//

class tile {
	private int value;			// tile value
	private boolean checked;	// tile checked
	private boolean flaged;		// tile flaged
	
	tile(int v){
		value = v;			// set value
		checked = false;	// defualt
		flaged = false;		// defualt
	}
	
	public int getVal(){ // return tile value
		return this.value;
	}
	
	public boolean getCheck(){ // return tile checked
		return this.checked;
	}
	
	public boolean getflag(){ // return tile flaged
		return this.flaged;
	}
	
	//-------New-CHANGE------------//
	public void setVal(int in){ // set tile value
		this.value = in;
	}
	
	public void setCheck(boolean in){ // set tile checked
		this.checked = in;
	}
	
	public void setflag(boolean in){ // set tile flaged
		this.flaged = in;
	}
	//----------------------------//
}

class map {
	int x;			// Columns
	int y;			// Rows
	tile[][] Map;	// Tile map
	
	map(){ // no input method
		x = 7;					// defualt size
		y = 7;					// defualt size
		Map = new tile[y][x];	// defualt size
		
		// for every row and column in the Map
		for(int i = 0; i < y; i++){
			for(int j = 0; j < x; j++){
				// Set tiles
				Map[i][j] = new tile(0);
			} 
		}
	}
	
	map(int ix, int iy){ // custom input method
		if(ix > 0){ x = ix; }else{ x = 7; }	// valid size or defualt
		if(iy > 0){ y = iy; }else{ y = 7; } // valid size or defualt
		Map = new tile[iy][ix];				// custom map size
		
		// for every row and column in the Map
		for(int i = 0; i < iy; i++){
			for(int j = 0; j < ix; j++){
				// Set tiles
				Map[i][j] = new tile(0);
			} 
		}
	}
	
	//-------New-CHANGE------------//
	public void placemines(){
		for(int i = 0; i < this.y; i++){
			for(int j = 0; j < this.x; j++){
				// plant bomb randomly tile
				if(((int)((Math.random() * 10) % 2)) == 1){
					Map[i][j] = new tile(-1);
				}
			} 
		}
	}
	//----------------------------//
	
	public void drawBoard(){
		String ret = "";	// create blank string
		
		// for every row and column in the Map
		for(int i = 0; i < this.y; i++){
			for(int j = 0; j < this.x; j++){
				// add value to string
				//-------New-CHANGE------------//
				if(!this.Map[i][j].getCheck()){
					ret = ret + " x,";
				}else{
					if(this.Map[i][j].getVal() < 0){
						ret = ret + this.Map[i][j].getVal() + ",";
					}else{
						ret = ret + " " + this.Map[i][j].getVal() + ",";
					}
				}
				//----------------------------//
			}
			
			// newline
			ret = ret + "\n";
		}
		
		// print string
		System.out.println(ret);
	}
	
	public boolean checkTile(int x,int y){ // Check tile at (x,y)
		// check if value is bomb
		if(this.Map[y][x].getVal() < 0){ return true; }
		return false;
	}
	
	//-------New-CHANGE------------//
	public void revealtile(int x, int y){
		this.Map[y][x].setCheck(true);
	}
	
	public boolean mapClear(){ // Check if the map is clear
		boolean ret = false;
		
		// for every row and column in the Map
		for(int i = 0; i < this.y; i++){
			for(int j = 0; j < this.x; j++){
				if(!this.checkTile(j,i)){
					if(!this.Map[j][i].getCheck()){
						ret = true;
					}
				}
			}
		}
		
		return ret;
	}
	
	public void showAll(){
		// for every row and column in the Map
		for(int i = 0; i < this.y; i++){
			for(int j = 0; j < this.x; j++){
				// show the tile
				this.Map[j][i].setCheck(true);
			}
		}
	}
	//----------------------------//
}

public class mine{ // Public Class
	public static void main(String[] args){ // Starter Function
		//-------New-CHANGE------------//
		Scanner in = new Scanner(System.in);
		int sx,sy;
		//----------------------------//
		map M = new map(); // create map
		// removed: System.out.println("x:" + M.x + ", y:" + M.y);
		// removed: M.drawBoard(); // Draw The Board
		//-------New-CHANGE------------//
		M.placemines(); // place mines
		do{
			System.out.println("");
			M.drawBoard(); // draw the map
			
			// get player input
			System.out.println("enter tile x: ");	// input text for x
			sx = in.nextInt();						// read x from stdin
			System.out.println("enter tile y: ");	// input text for y
			sy = in.nextInt();						// read y from stdin
			
			if(M.checkTile(sx - 1,sy - 1)){
				// if tile is a bomb
				System.out.println("\nTHAT'S A BOMB");
				System.out.println("GAME OVER\n");	// loser XD
				break;
			}
			
			M.revealtile(sx - 1,sy - 1); // show the tile
		}while(M.mapClear()); // while the map is not clear
		if(!M.mapClear()){
			System.out.println("\nYOU WIN\n"); // winner :D
		}
		M.showAll();	// show the map
		M.drawBoard();	// draw the map
		//----------------------------//
		// Zero Errors
	}
}
