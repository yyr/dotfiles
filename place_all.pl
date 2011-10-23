#!/usr/bin/env perl
#---------------------------------------------------------------------------
# Author: yagnesh raghava yakkala  Email: yagneshmsc@NOSPAMgmail.com
# DATE: 2010-08-19
# Purpose:  this document puts all dot files in correct folders and
#  changes the names as well (destination and name should be in the file)
# Current Version: 0.1
# Latest change by yagnesh on <2010-08-27 Fri>
#---------------------------------------------------------------------------
use strict;
use warnings;
use File::Basename;
use File::Copy;

my $Home = $ENV{'HOME'};
my $base_dir = shift // '.' ;
my ($this_script)=fileparse("$0"); # aquire the script name
my @excludes = ( '.gitignore', 'nytprof.out', 'place_all.pl', 'README.org' ) ; # add here for skipping from process by this script
opendir(my $dh, $base_dir ) || die  "cannot open Directory $base_dir : $! \n";
my @files = readdir($dh);
closedir $dh;

sub get_file_details {
  my $fname_in = shift ;
  my $dir;
  my $fname_out;

  open(my $fh, '<', "$fname_in") or die "cannot open $fname_in :$! \n";

  while (<$fh>) {
    if (/.\+DEST=(.*)/i) {
      $dir = $+;
    }

    if (/.\+FNAME=(.*)/) {      # acquire the destination file name
      $fname_out = $+;
      last if (defined($dir) and defined($fname_out));
    }
  }
  close($fh);
  return(  "$dir", "$fname_out" )
}

foreach my $x (@files) {
  next if ( -d $x );          # skip for . and .. or any dirs comes in

  next if ( "$this_script" eq $x ); #skip the current script
  next if ($x ~~ @excludes);        #skip those are in excludes
  next if ( $x =~ /.back$/ );       # skip if it is backed up file
  my ($dest_dir , $copy_as ) = get_file_details($x);
  $dest_dir =~ s/\$HOME/$Home/;
  my $copy_as_in = "$dest_dir"."$copy_as"; # concat the destnation dir and file
  print $x ,"  -->  " ,$copy_as_in, "\n";
  copy($x,$copy_as_in) or die "Copy Failed: $!";
}
