#!/usr/bin/perl
#ASCII to APL: write APL without having to buy a stupid glyph keyboard!
#usage: perl ascii2apl.pl [aplfile]

#current function glyphs listed (feel free to add more)
#ceil == ceiling U+2308
#flr == floor U+230A
#rho U+2374
#iota U+2373
#sig == signum U+00D7
#mat == matrix inverse/divide U+2339
#circ == circle U+25CB
#log == logarithm U+235F
#revl/rotl == reverse/rotate last U+233D
#revf/rotf == reverse/rotate first U+2296
#gup == grade up U+234B
#gdn == grade down U+2352
#exec == execute U+234E
#eps == epsilon U+2208 
#epsu == epsilon underbar U+2377
#take U+2191
#drop U+2193
#dec == decode U+22A5
#enc == encode U+22A4
#form == format U+2355
#trans == transpose U+2349 
#dd == double dot U+00A8
#leq == less than or equal to U+2264
#geq == greater than or equal to U+2265
#ne == not equal U+2260
#or U+2228
#and U+2227
#nor U+2371
#nand U+2372
#left U+22A3
#right U+22A2
#redax == reduce first axis U+233F
#scanax == scan first axis U+2340
#out == outer product U+2218 + .
open($file, "<", "$ARGV[0]") or die "Error: $!\n";
@filearr = <$file>;
close($file);
$filearr1 = join("", @filearr);
print $filearr1;
$filearr1 =~ s/ceil/\x{2308}/ig;
$filearr1 =~ s/flr/\x{230a}/ig;
$filearr1 =~ s/rho/\x{2374}/ig;
$filearr1 =~ s/iota/\x{2373}/ig;
$filearr1 =~ s/sig/\x{00d7}/ig;
$filearr1 =~ s/mat/\x{2339}/ig;
$filearr1 =~ s/circ/\x{25cb}/ig;
$filearr1 =~ s/log/\x{235f}/ig;
$filearr1 =~ s/r(ev|ot)l/\x{233d}/ig;
$filearr1 =~ s/r(ev|ot)f/\x{2296}/ig;
$filearr1 =~ s/gup/\x{234b}/ig;
$filearr1 =~ s/gdn/\x{2352}/ig;
$filearr1 =~ s/exec/\x{234e}/ig;
$filearr1 =~ s/epsu/\x{2377}/ig;
$filearr1 =~ s/eps/\x{2208}/ig;
$filearr1 =~ s/take/\x{2191}/ig;
$filearr1 =~ s/drop/\x{2193}/ig;
$filearr1 =~ s/dec/\x{22a5}/ig;
$filearr1 =~ s/enc/\x{22a4}/ig;
$filearr1 =~ s/form/\x{2355}/ig;
$filearr1 =~ s/trans/\x{2349}/ig;
$filearr1 =~ s/dd/\x{00a8}/ig;
$filearr1 =~ s/leq/\x{2264}/ig;
$filearr1 =~ s/geq/\x{2265}/ig;
$filearr1 =~ s/ne/\x{2260}/ig;
$filearr1 =~ s/or/\x{2228}/ig;
$filearr1 =~ s/and/\x{2227}/ig;
$filearr1 =~ s/nor/\x{2371}/ig;
$filearr1 =~ s/nand/\x{2372}/ig;
$filearr1 =~ s/left/\x{22a3}/ig;
$filearr1 =~ s/right/\x{22a2}/ig;
$filearr1 =~ s/redax/\x{233f}/ig;
$filearr1 =~ s/scanax/\x{2340}/ig;
$filearr1 =~ s/out/\x{2218}\./ig;
print $filearr1;
open($file, ">", "$ARGV[0]");
print $file $filearr1;
close($file);
