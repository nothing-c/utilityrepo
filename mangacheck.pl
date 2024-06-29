#!/usr/bin/perl

use v5.10; use HTTP::Tiny;

=pod

Usage: mangacheck [link] [link] [link]...

Good for the Manganelo/Manganato/Mangakakalot family of manga sites

Extension of https://nothing-c.neocities.org/code-snippets

=cut

sub date($) {
    my $l=shift; my $h=HTTP::Tiny->new(); my $r=$h->get($l); die "Could not retrieve manga" unless $r->{success};
    my $x=(grep /Update/,split "\n",$r->{content})[0]; $x =~ m/.*<.*>(.*)<\/span><\/p>/; return $1;
}

sub chaps($) {
    my $l=shift; my $h=HTTP::Tiny->new(); my $r=$h->get($l); die "Could not retrieve manga" unless $r->{success};
    my $x=(grep /li class/,split "\n",$r->{content}); return $x;
}

sub name($) {
    my $l=shift; my $h=HTTP::Tiny->new(); my $r=$h->get($l); die "Could not retrieve manga" unless $r->{success};
    my $x=(grep /<h1>/,split "\n",$r->{content})[0]; $x =~ m/>(.+)</; return $1;
}

while (<@ARGV>) {
    printf "%s: %d chapters, last updated %s\n",name $_,chaps $_,date $_;
}
