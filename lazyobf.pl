#!/usr/bin/perl
#the lazy obfuscator: read file, pack to hex, write hex to stdout
#usage: lazyobf [-pu] filein 

if ($ARGV[0] =~ /p/g) {
    open($filein, "<", "$ARGV[1]");
    while (<$filein>) {
	#turn into hex
	$o = unpack("H*", $_);
	print $o;
    }
} elsif ($ARGV[0] =~ /u/g) {
    open($filein, "<", "$ARGV[1]");
    while (<$filein>) {
	#turn from hex
	@e = ($_ =~ m/..*/g);
	$a = pack("H*", @e);
	print $a; 
    }
} else {
    print "unknown option";
}

print "\n";
