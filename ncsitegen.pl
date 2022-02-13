#Generate N-C Softworks sites from markdown

$styles = "<style>body {background-color: #262625} p,h1,h2,h3,h4,h5,h6 {color: white; text-align: center; font-family: arial; font-size: 120%} ul,li {list-style-position: inside; color: white; text-align: center; font-family: arial} </style>"; 

$infile = $ARGV[0];
@outformat;
$paracount = 1;
open($filein, "<", "$infile");
@lines = <$filein>;
close($filein);
$i = 0;
for $line (@lines){
	#bold
	$line =~ s/\*\*(\s|\n)/<\/b>/g;
	$line =~ s/\*\*/<b>/g;
	#italics
	$line =~ s/\*(\s|\n)/<\/i>/g;
	$line =~ s/\*/<i>/g;
	#strikethrough
	$line =~ s/~~(\s|\n)/<\/strike>/g;
	$line =~ s/~~/<strike>/g;
	#links
	if ($line =~ /\[.+\]\(.+\)/){
		$line = urlreplace($line);	
	}
	#bullets
	if ($line =~ /^\+/){
		#hacky
		$line =~ s/\+//;
		$line = "<ul><li>$line</li>";
		$k = $i + 1;
		until ($lines[$k] !~ /^\+/){
			$lines[$k] =~ s/\+//;
			$lines[$k] = "<li>$lines[$k]</li>";
			$k++;
		}
		$lines[$k] = "</ul>$lines[$k]";
	}
	#numbered lists
	if ($line =~ /^[1-999]\./){
		$line = "<p>$line</p>";	
	}
	#headers
	if ($line =~ /^#/){
		$tmp = substr($line, 0, 6);
		@tmp0 = split('', $tmp);
		pop(@tmp0) until ($tmp0[scalar @tmp0 - 1] =~ /#/);
		$len = scalar @tmp0;
		$line =~ s/#{$len}/<h$len>/;
		$line =~ s/\n/<\/h$len>\n/;
	}
	#paragraphs
	if ($line =~ /^\n/){
		if ($paracount % 2 == 1){
			$line = "<p>$line";
			$paracount++;
		} else {
			$line = "</p>$line<p>";
			$paracount++;
		}
	}
	print $line;
	push(@outformat, $line);
	$i++;
}

sub urlreplace{
	#isolate link
	@tmp = split(m/\[/, $_[0]);
	@tmp0 = split(m/\]/, $tmp[1]);
	$tmp0[1] =~ s/\(//;
	$tmp0[1] =~ s/\)//;
	$replacement = "<a href=\'$tmp0[1]\'>$tmp0[0]</a>";
	#repeat until out of links
	while ($replacement =~ /\[.*\]\(.*\)/){
		$replacement = urlreplace($replacement);	
	}
	return $replacement;
}

$infile =~ s/\.md/\.html/;
open($outfile, ">", "test.html");
print $outfile $styles;
print $outfile @outformat;
print $outfile "<!-- Generated with N-C Softworks Site Generation Tool -->";
close($outfile);
print "Finished\n";
