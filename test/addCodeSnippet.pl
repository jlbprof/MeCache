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

    my $content = qq{
{
    "key1": "value1",
    "key2": "value2",
    "key3": [
        "abc",
        "def",
        "ghi"
    ]
}
};

    if (open my $fh, '>', "tempfile.json")
    {
        print $fh $content;
        close $fh;
    }
    else
    {
        die "Cannot open tempfile.json";
    }

    print `./mecache put --to master CodeSnippet JSON justatest tempfile.json` . "\n";

    unlink "tempfile.json";

	return 1;
}

script (@ARGV) unless caller ();


