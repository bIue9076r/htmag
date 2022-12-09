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
	
	public void drawBoard(){
		String ret = "";	// create blank string
		
		// for every row and column in the Map
		for(int i = 0; i < this.y; i++){
			for(int j = 0; j < this.x; j++){
				// add value to string
				ret = ret + this.Map[i][j].getVal() + ",";
			}
			
			// newline
			ret = ret + "\n";
		}
		
		// print string
		System.out.println(ret);
	}
	
	public boolean checkTile(int x,int y){ // Check tile at (x,y)
		// check if value is bomb
		if(this.Map[y][x].getVal() < 0){ return false; }
		return true;
	}
	
	public boolean mapClear(){ // Check if the map is clear
		// placeholder method
		return true;
	}
}

public class mine{ // Public Class
	
	public static void main(String[] args){ // Starter Function
		map M = new map(); // create map
		System.out.println("x:" + M.x + ", y:" + M.y);
		M.drawBoard(); // Draw The Board
		// Zero Errors
	}
}
