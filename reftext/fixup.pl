undef $/ ;
while (<>) {
	s/\x{e2}\x{80}\x{99}/\'/g ;
	s/\x{e2}\x{80}\x{98}/\'/g ;
	s/\x{e2}\x{80}\x{9d}/\"/g ;
	s/\x{e2}\x{80}\x{8b}//g ;
	s/\o{342}\o{200}\o{223}//g ;
	s/\o{342}\o{200}\o{246}/.../g ;
	s/\x{e2}\x{80}\x{9c}/\"/g ;
	s/\nSp\necial/\nSpecial/igs ;
	s/\nWe\napon/\nWeapon/igs ;
	s/Special Rules:\n/Special Rules: /igs ;
	s/\nWA\nR /\nWAR /igs ;
	s/\nRA\nRE\n/\nRARE\n/igs ;
	s/\nArmour:\n/\nArmour: /igs ;
	s/\nWeapon:\n/\nWeapons: /igs ;
	s/\nMagic:\n/\nMagic: /igs ;
	s/\nWe\napons:\n/\nWeapons: /igs ;
	s/\'\'/\"/g ;
	s/  / /g ;
	print $_;
}