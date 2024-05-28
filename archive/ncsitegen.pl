#Generate N-C Softworks sites from markdown

$styles = "<style>body {background-color: #262625;color: white; text-align: center; font-family: arial; font-size: 120%} p,h1,h2,h3,h4,h5,h6 {color: white; text-align: center; font-family: arial; font-size: 120%} ul,li {list-style-position: inside; color: white; text-align: center; font-family: arial} </style>"; 

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
	#strikethrough
	$line =~ s/~~(\s|\n)/<\/strike>/g;
	$line =~ s/~~/<strike>/g;
	#links
	if ($line =~ /\[.+\]\(.+\)/){
		$line = urlreplace($line);	
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
	$line =~ s/\n/<br>/;
	#print $line;
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
open($outfile, ">", "$infile");
print $outfile "<html>";
print $outfile $styles;
print $outfile @outformat;
print $outfile "<!-- Generated with N-C Softworks Site Generation Tool -->";
print $outfile "</html>";
close($outfile);
print "Finished\n";
