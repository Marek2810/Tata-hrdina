// Táta hrdina autosplitter and load remover by Marek28110
// Version: 0.50
state("Táta hrdina")
{
	byte isLoading : 0xCC44, 0x298;
	byte letsgo : 0x93925C, 0xB9;
	byte loadedlevel : 0x939260, 0x18;
	byte level : 0x939218, 0x4, 0x0, 0x100;
}

startup
{
  settings.Add("IL_Start", false, "Start time with loading every level");
}

start {
	if (current.loadedlevel == 0 && current.letsgo == 1) return true;	

	if (settings["IL_Start"]){
        if (current.letsgo == 1) return true;        
    }
}

isLoading {
	if (current.isLoading != 80) {
		return true;
	} 
	return false;
}

reset
{
	if (current.loadedlevel == 0 && current.loadedlevel != new.loadedlevel) return true;
}

split {		

	if (old.level != current.level && current.loadedlevel == current.level-1) {
		print("end of level " + current.loadedlevel)
		print("-----")
		return true;
	}
	
	if (current.letsgo != old.letsgo) {
		print("old LETSGO is " + old.letsgo);
		print("current LETSGO is " + current.letsgo);
	}
	if (current.level != old.level) {
		print("old LEVEL is " + old.level);
		print("current LEVEL is " + current.level);
	}
	if (current.letsgo == 1) {
		print("----")
		print("start of level " + current.loadedlevel)
	}	
}

