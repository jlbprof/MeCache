#!/usr/bin/perl

use strict;
use warnings;

use Carp;
use Getopt::Long;
use Path::Tiny;
use MIME::Base64;
use Data::Dumper;
use Cpanel::JSON::XS;

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

	die "Specify filename" if (@args < 1);

	my $path = Path::Tiny::path ($args[0]);
	my $content = $path->slurp ();

	my $encoded = MIME::Base64::encode_base64 ($content);

	my $data = {
		type => 'File',
		name => $args[0],
		content => $encoded,
		size => length ($content)
	};

	my $coder = Cpanel::JSON::XS->new->ascii->pretty->allow_nonref ();
	my $json_text = $coder->encode ($data);

print $json_text . "\n";

	return 1;
}

script (@ARGV) unless caller ();


