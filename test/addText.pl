#!/usr/bin/perl

use strict;
use warnings;

use Carp;
use Getopt::Long;

$| = 1;

$SIG{__WARN__} = sub {
	my ($sig) = @_;

	print "WARN :$sig:\n";

	print Carp->longmess . "\n";

	exit 0;
};

$SIG{__DIE__} = sub {
	my ($sig) = @_;

	print "DIE :$sig:\n";
	print Carp->longmess . "\n";

	exit 0;
};

$SIG{TERM} = sub {
	my ($sig) = @_;

	exit 0;
};

$SIG{INT} = sub {
	my ($sig) = @_;

	exit 0;
};

sub script
{
	my (@args) = @_;

    my $content = qq{Line01
Line02
Line03
Line04
Line05
};

    if (open my $fh, '>', "tempfile.txt")
    {
        print $fh $content;
        close $fh;
    }
    else
    {
        die "Cannot open tempfile.txt";
    }

    print `./mecache put --to master Text tempfile.txt` . "\n";

    unlink "tempfile.txt";

	return 1;
}

script (@ARGV) unless caller ();


