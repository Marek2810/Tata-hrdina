// Táta hrdina autosplitter and load remover by Marek28110
// Version: 0.50
state("Táta hrdina")
{
	byte isLoading : 0x85E0, 0x2A4;
	byte letsgo : 0x93925C, 0xB9;
	byte loadedlevel : 0x939260, 0x18;
	byte level : 0x939218, 0x4, 0x0, 0x100;
}

startup
{
  settings.Add("IL_Start", false, "Start time with loading every level");
}

start {
	if (current.loadedlevel == 0 && old.letsgo == 1 && current.letsgo == 0) return true;	

	if (settings["IL_Start"]){
        if (old.letsgo == 1 && current.letsgo == 0) return true;        
    }
}

reset {
	if (old.loadedlevel != current.loadedlevel && current.loadedlevel == 0) return true; 
}

isLoading {
	if (current.isLoading != 0) {
		return true;
	} 
	return false;
}

split {	
	//Log:
		//start of level
		if (old.loadedlevel != current.loadedlevel && old.letsgo != current.letsgo && current.letsgo == 1) {
			print("----");
			print("start of level " + current.loadedlevel);
		}	
		// letsgo change
		if (current.letsgo != old.letsgo) {
			print("old LETSGO: " + old.letsgo + "current LETSGO is " + current.letsgo);
		}
		//level change
		if (current.level != old.level) {
			print("old LEVEL: " + old.level + "current LEVEL: " + current.level);
		}	
		//isLoading change
		if (current.isLoading != old.leisLoadingvel) {
			print("old isLoading: " + old.isLoading + "current isLoading: " + current.isLoading);
		}	

	//End of level		
	if (old.level != current.level && current.loadedlevel == current.level-1) {
		print("end of level " + current.loadedlevel);
		print("-----");
		return true;
	}	
}