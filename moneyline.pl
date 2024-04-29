#!/usr/bin/perl
# moneyline odds -> actual odds + hold

#fmt: moneyline [odds]
#ex: moneyline +150 -175 -> 38.60% 61.40% 3.64%

@ro; map { s/\+//g; push(@ro,$_ < 0 ? abs($_)/(abs($_)+100) : 100/(100+$_)) } @ARGV; #raw odds
$h = 0; map { $h+=$_ } @ro; #hold
$t = 1; #track outcome
map { printf("P(Outcome %i): %.2f\%\n", $t, 100*($_/($h))); $t++ } @ro; #pretty dump
printf("Hold: %.2f\%\n",100*($h-1));

# map {printf("%.2f ",100*($_/($h)))} @ro; #ugly but utilitarian dump
# printf("%.2f\n",100*($h-1));
