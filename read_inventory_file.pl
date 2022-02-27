sub read_inventory_file {
	use feature say;
	my $name = $_[0];
	my %inventory = ();
	my $key = "a";
	my $item = "a";
	my $aug1 = "a";
	my $aug2 = "a";

	unless (open (IN, "/home/eqemu/inventories/$name-Inventory.txt"))
	{
		print "ERROR : could not open the inventory file";
		exit;
	}

	while($line = <IN>)
	{
		chomp($line);
		@line_info = split(/\t/, $line);
		if (index($line_info[0], "Charm") != -1 || index($line_info[0], "Primary") != -1 || index($line_info[0], "Secondary") != -1 || index($line_info[0], "Range") != -1 || index($line_info[0], "Fingers") != -1
			|| index($line_info[0], "Feet") != -1 || index($line_info[0], "Hands") != -1 || index($line_info[0], "Legs") != -1 || index($line_info[0], "Wrist") != -1 || index($line_info[0], "Waist") != -1 
			|| index($line_info[0], "Shoulders") != -1 || index($line_info[0], "Arms") != -1 || index($line_info[0], "Back") != -1 || index($line_info[0], "Chest") != -1
			|| index($line_info[0], "Neck") != -1 || index($line_info[0], "Ear") != -1 || index($line_info[0], "Head") != -1  || index($line_info[0], "Face") != -1) {
			# Deal with the multivalue ones
			if (index($line_info[0], "Fingers") != -1) {
				if (index($line_info[0], "Slot") == -1) {
					$key = "Finger1";
					$item = $line_info[2];
				}	
				if (exists $inventory{"Finger1"} && index($line_info[0], "Slot") == -1) {
					$key = "Finger2";
					$item = $line_info[2];
				}	
				if (index($line_info[0], "Slot1") != -1 && index($line_info[1], "Empty") == -1) {
					$aug1 = $line_info[2];
				}
				elsif (index($line_info[0], "Slot1") != -1) {
					$aug1 = "Empty";
				}
				else {
					$aug1 = "a";
				}
				if (index($line_info[0], "Slot2") != -1 && index($line_info[1], "Empty") == -1) {
					#Basically there is a second aug
					$aug2 = $line_info[2];
				}
				elsif (index($line_info[0], "Slot2")) {
					$aug2 = "Empty";
				}
				else {
					$aug2 = "a";
				}
			}
			elsif (index($line_info[0], "Ear") != -1) {
				if (exists $inventory{"Ear1"} && index($line_info[0], "Slot") == -1) {
					$key = "Ear2";
					$item = $line_info[2];
				}	
				elsif (index($line_info[0], "Slot") == -1) {
					$key = "Ear1";
					$item = $line_info[2];
				}	
				if (index($line_info[0], "Slot1") != -1 && index($line_info[1], "Empty") == -1) {
					$aug1 = $line_info[2];
				}
				elsif (index($line_info[0], "Slot1") != -1) {
					$aug1 = "Empty";
				}
				else {
					$aug1 = "a";
				}
				if (index($line_info[0], "Slot2") != -1 && index($line_info[1], "Empty") == -1) {
					#Basically there is a second aug
					$aug2 = $line_info[2];
				}
				elsif (index($line_info[0], "Slot2")) {
					$aug2 = "Empty";
				}
				else {
					$aug2 = "a";
				}
			}	
			elsif (index($line_info[0], "Wrist") != -1) {
				if (exists $inventory{"Wrist1"} && index($line_info[0], "Slot") == -1) {
					$key = "Wrist2";
					$item = $line_info[2];
				}	
				elsif (index($line_info[0], "Slot") == -1) {
					$key = "Wrist1";
					$item = $line_info[2];
				}	
				if (index($line_info[0], "Slot1") != -1 && index($line_info[1], "Empty") == -1) {
					$aug1 = $line_info[2];
				}
				elsif (index($line_info[0], "Slot1") != -1) {
					$aug1 = "Empty";
				}
				else {
					$aug1 = "a";
				}
				if (index($line_info[0], "Slot2") != -1 && index($line_info[1], "Empty") == -1) {
					#Basically there is a second aug
					$aug2 = $line_info[2];
				}
				elsif (index($line_info[0], "Slot2")) {
					$aug2 = "Empty";
				}
				else {
					$aug2 = "a";
				}
			}						
			else {
				# Not multivalue
				if (index($line_info[0], "Slot") == -1) {
						$key = $line_info[0];
						$item = $line_info[2];
				}	
				if (index($line_info[0], "Slot1") != -1 && index($line_info[1], "Empty") == -1) {
					$aug1 = $line_info[2];
				}
				elsif (index($line_info[0], "Slot1") != -1) {
					$aug1 = "Empty";
				}
				else {
					$aug1 = "a";
				}
				if (index($line_info[0], "Slot2") != -1 && index($line_info[1], "Empty") == -1) {
					#Basically there is a second aug
					$aug2 = $line_info[2];
				}
				elsif (index($line_info[0], "Slot2") == -1) {
					$aug2 = "Empty";
				}
				else {
					$aug2 = "a";
				}	
			}	
			if ($key ne "a" && $item ne "a" && $aug1 ne "a" && $aug2 ne "a") {
				# Push to the HOA
				$inventory{$key} = [$item, $aug1, $aug2];
				$key = "a";
				$item = "a";
				$aug1 = "a";
				$aug2 = "a";
			}	
		}
	}
	# close the file
	close(IN);

	return %inventory;
}