#!/usr/bin/perl

use strict;
use warnings;

use Carp;
use Data::Dumper;

use MeCache::Init;

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

sub usage
{
	my ($msg) = @_;

	print "Error: $msg\n";
	print "usage: TBD\n";

	exit 0;
}

sub script
{
	my (@args) = @_;

	my $dir = MeCache::Init::init_from_dir ('master');
	my $heading = $dir->summary_heading ();
	return if !$heading;

	my @summaries = $dir->summary ();

	foreach my $summary (@summaries)
	{
		print $summary . "\n";
	}

	return 1;
}

script (@ARGV) unless caller ();


