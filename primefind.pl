#!/usr/bin/perl

#works! 
#find prime numbers
our @arr = (2, 3, 5, 7, 11, 13);
#initial arr can be modified
our $current = 14;
main();
sub main{
    $i = 0;
    while ($i < scalar @arr){
	#print $i;
	if (($current % $arr[$i]) == 0){
	    $current++;
	    #print "blagh";
	    main();
        } elsif ($i == (scalar @arr - 1)){
	    push(@arr, $current);
	    print $current;
	    print "New prime found!\n";
	    $current++;
	    main();
	}
       	$i++;
    }
}
