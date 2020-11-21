package MeCache::Init;

use strict;
use warnings;

use Path::Tiny;
use File::chdir;
use Cpanel::JSON::XS;

use Data::Dumper;
use MeCache::Meta;
use MeCache::Message;
use MeCache::Dir;
use MeCache::Bookmark;
use MeCache::File;

use Try::Tiny;

sub init_from_file
{
	my ($filename, $pinned) = @_;

	$pinned ||= 0;

	die "Must pass in an actual file" if (!-f $filename);

	my $basename = Path::Tiny::path ($filename)->basename;

	# we must be in the directory that the file resides in
	# File must be of the form 12345.meta

	# file names must be of the form:  999999999-99999-99999.meta
	# The first group of 9's are the unix timestamp at creation
	# The second group of 9's is the process id
	# The third group of 9's is a random number
	# The second and third group allow for asynchronous file creations, with
	# almost no chance of simultaneous creation

	my $created;
	if ($basename =~ m/^([0-9]+)_([0-9]+)_([0-9]+)\.meta$/)
	{
		$created = int($1);
	}
	else
	{
		die "Not of the right form ($filename)";
	}

	my $json_data = Path::Tiny::path ($filename)->slurp ();
	my $meta = Cpanel::JSON::XS::decode_json ($json_data);

	my $dt = DateTime->from_epoch ( epoch => $created );
	$meta->{'dt'} = $dt;

	die "Type not specified" if (!exists $meta->{'type'});

	$meta->{'filename'} = $filename;
	$meta->{'created'} = $created;
	$meta->{'pinned'} = $pinned;

	# TBD: a general way of initializing
	if ($meta->{'type'} eq "Meta")
	{
		return MeCache::Meta::init_from_meta ($meta);
	}
	elsif ($meta->{'type'} eq "Message")
	{
		return MeCache::Message::init_from_meta ($meta);
	}
	elsif ($meta->{'type'} eq "Bookmark")
	{
		my $xmeta = MeCache::Bookmark::init_from_meta ($meta);
		return $xmeta;
	}
	elsif ($meta->{'type'} eq "File")
	{
		my $xmeta = MeCache::File::init_from_meta ($meta);
		return $xmeta;
	}

	die "Unknown Meta Type";
	return;
}

sub init_from_dir
{
	my ($dir, $pinned) = @_;

	$pinned ||= 0;

	my $pdir = Path::Tiny::path ($dir);
	die "Must be a directory" if $pdir->is_file;

	my @children = $pdir->children;
	my @metas;

	foreach my $child (@children)
	{
		next if $child->is_dir;

		my $meta;

		try {
			$meta = init_from_file ($child, $pinned);
		};

		next if !$meta;

		push (@metas, $meta);
	}

	my $obj = MeCache::Dir->new (
		metas => \@metas,
	);

	return $obj;
}

1;

__END__


