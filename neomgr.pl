#!/usr/bin/perl

use v5.10;
use HTTP::Tiny;
use Pod::Html;

# manager script for Neocities
# https://neocities.org/api

my $auth=""; # username:password
my $h=HTTP::Tiny->new();

# returns full JSON
# http instance, auth
sub list($$) {
    my $h=shift; my $auth=shift;
    my $r=$h->get("https://$auth\@neocities.org/api/list");
    return $r->{content} if $r->{success};
    die "Command List failed: $r->{status} $r->{reason} $r->{content}";
}

# convert list to plain array
sub clist ($$) {
    my $h=shift; my $auth=shift;
    my @x = map { $1 if /:\s"(.+\.html)"/;} grep /html/,split /\n/,list $h,$auth;
    return @x;
}

# returns full JSON
# http instance, auth
sub info ($$) {
    my $h=shift; my $auth=shift;
    my $r=$h->get("https://$auth\@neocities.org/api/info");
    return $r->{content} if $r->{success};
    die "Command Info failed: $r->{status} $r->{reason} $r->{content}";
}

# prettify info
# http instance, auth
sub pinfo ($$) {
    my $h=shift; my $auth=shift;
    my @x= map { s/"|\s{4}|,//g; s/_/ /; ucfirst $_ } grep /\s{4}/,split /\n/,info $h,$auth;
    say join "\n",@x[0..4];
}

# http instance, auth, filename (on-server), file contents (as scalar)
sub upload ($$$$) { # this took 2 hours
    my $h=shift; my $auth=shift; my $name=shift; my $cont=shift;
    my %opt = (
	'accept' => '*/*',
	'content-type' => 'multipart/form-data; boundary=boundary'
    );
    my $r=$h->request('POST',"https://$auth\@neocities.org/api/upload", {
	'content'=>qq(--boundary\r\nContent-Disposition: form-data; name="$name"; filename="$name"\r\nContent-Type: text/html\r\n\r\n$cont\r\n--boundary--),
	    'headers' => {'content-type' => 'multipart/form-data; boundary=boundary'}});
    return $r->{content} if $r->{success};
    die "Command Upload failed: $r->{status} $r->{reason} $r->{content}";
}

# http instance, auth
sub sync ($$) {
    my $h=shift; my $auth=shift;
    my @rem=clist $h,$auth; @rem=sort @rem; # it doesn't like composing sort with clist
    opendir(my $d,'./'); my @loc=sort grep /\.html/,readdir $d; closedir $d;
    #@m;
    #foreach (@loc) { my $x = $_; my @t=grep /$_/,@rem; push @m,$x if 0 == scalar @t; say $x;}
    #@m=map { say; $_ unless scalar (grep /$_/,@rem); say; } @loc; # find missing
    @m=map { my $x=$_; $x unless grep /$x/,@rem } @loc; @m=grep /\.html/,@m;
    say "Uploading " . join ", ",@m;
    foreach (@m) { open my $f,"<",$_; say "$_ successfully uploaded" if upload $h,$auth,$_,<$f>; close $f; }
}

sub help {
    say 'Neocities site manager
Usage: neomgr [info|sync|list|help]
- info: shows site information (hits, etc.)
- sync: uploads all local HTML files not on the Neocities server
- list: lists all pages currently on the Neocities server
- help: displays this message';
    exit;
}

# Prettyprint list
# http instance, auth
sub plist ($$) {
    my $h=shift; my $auth=shift;
    say "Current site contents:";
    say join "\n",clist $h,$auth;
}

our %cmd = (
    info => \&pinfo,
    sync => \&sync,
    list => \&plist
   );

help if ($#ARGV < 0) || !(exists $cmd{$ARGV[0]});
$cmd{$ARGV[0]}->($h,$auth);
