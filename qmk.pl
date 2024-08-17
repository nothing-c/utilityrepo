=pod

Usage: qmk file1 file2 file3...

deploy for scripts: cut off file extension, chmod, and dump into usr/local/bin/
a small, sharp tool in the sense that it's one line and you can easily cut off both your thumbs if you use it wrong
only applies to script files (.pl, .py, etc)

=cut
for (@ARGV) { $i=$_; $_ =~ s/\..+$//; open $of,">","/usr/local/bin/$_" or die "Could not access /usr/local/bin/!"; open $if,"<",$i; print $of join "\n",(<$if>); close $if; close $of; chmod 0755 "/usr/local/bin/$_" or die "Could not chmod $_!"; }
