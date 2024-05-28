#!/usr/bin/perl

#terminal key-value store for use in scripts

#format: perl key-val.pl [key] [value] (to store)
#        perl key-val.pl [key] (to print)
#init format: perl key-val.pl init
#WARNING: INIT'ING MORE THAN ONCE WILL WIPE THE KEYVAL FILE

#stores key-value pairs in a ~/.keyval file
use Cwd;

$home = glob("~/");
chop $home;
if ((scalar @ARGV) < 2) {
    if ($ARGV[0] =~ /init/) {
	open($keys, ">>", "$home/.keyval") or die "Could not open keyfile";
	print $keys "#keyval init\n";
	close($keys);
    } else {
        #nab the key
	$flag = 0;
	open($keys, "<", "$home/.keyval");
	while (<$keys>) {
	    if ($_ =~ /$ARGV[0]/g) {
		$_ =~ /(.*):(.*)\n/;
		print $2;
		$flag++;
		break;
	    }
	}
	if ($flag < 1) {
	    print "Error: key not found\n";
	}
	close($keys);
    }
} else {
    open($keys, ">>", "$home/.keyval");
    print $keys "$ARGV[0]:$ARGV[1]\n";
    close($keys);
}

