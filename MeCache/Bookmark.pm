package MeCache::Bookmark;

use strict;
use warnings;

use Moo;

extends 'MeCache::Meta';

has description => ( 'is' => 'ro' );
has url => ( 'is' => 'ro' );

sub init_from_meta
{
	my ($meta) = @_;

	die "Description missing" if (!exists $meta->{'description'});
	die "URL missing" if (!exists $meta->{'url'});

	my $obj = MeCache::Bookmark->new (
		type => "Bookmark",
		filename => $meta->{'filename'},
		created => $meta->{'created'},
		description => $meta->{'description'},
		url => $meta-> {'url'},
		dt => $meta->{'dt'},
	);

	return $obj;
}

sub debug
{
	my ($self) = @_;

	my $debug = $self->SUPER::debug ($self);
	$debug .= " Bookmark Description (" . $self->description . ":" . $self->url . ")";

	return $debug;
}

sub summary
{
	my ($self) = @_;

	my $summary = sprintf ("%-8.8s %10.10s %-68.68s", $self->type, $self->dt ()->ymd, $self->description);

	return $summary;
}

sub clone_essentials
{
	my ($self) = @_;

	my $clone = {
		type  => $self->type,
		description => $self->description,
		url => $self->url
	};

	return $clone;
}

1;

__END__



