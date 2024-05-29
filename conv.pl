#!/usr/bin/perl

use v5.10;

# Quick batch converter for pod -> HTML w/ my site style/mods
# Usage: conv [pod file list]
while (<@ARGV>) {
    $if = $_; s/\.pod/.html/; open $OF,">",$_;
    foreach (`pod2html --noindex --infile=$if --title=AUTOGEN`){
	print $OF '<style>body {background-color: #262625;color: white; font-family: arial; font-size: 120%}p,h1,h2 {color: white; font-family: arial; font-size: 120%}a:link {color: #d468d4}a:visited {color: #d69fd6}</style>' if /\/head/;
	print $OF '<p><a href="https://nothing-c.neocities.org">Home</a></p>' if /\/body/;
	print $OF $_;
    }
    close $OF;
}

system 'del pod2htmd.tmp'if -e 'pod2htmd.tmp'; # rm if *NIX
