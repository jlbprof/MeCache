package MeCache::Bookmark;

use strict;
use warnings;

use Moo;

extends 'MeCache::Meta';

has description => ( 'is' => 'ro' );
has url => ( 'is' => 'ro' );
has content => ( 'is' => 'ro' );
has content_is_base64 => ( is => 'ro' );

sub init_from_meta
{
	my ($meta) = @_;

	die "Description missing" if (!exists $meta->{'description'});
	die "URL missing" if (!exists $meta->{'url'});

	my $obj = MeCache::Bookmark->new (
		type => "Bookmark",
		id => $meta->{'filename'},
		created => $meta->{'created'},
		description => $meta->{'description'},
		url => $meta-> {'url'},
		dt => $meta->{'dt'},
		where => $meta->{'where'},
		content => $meta->{'url'},
		content_is_base64 => 0,
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

sub get_base_data
{
	my ($self) = @_;

	my $clone = {
		type  => $self->type,
		description => $self->description,
		url => $self->url
	};

	return $clone;
}

sub get_list_formatted
{
	my ($self) = @_;

	my $output = [];

	push (@{$output}, "Bookmark: ID " . $self->id);
	push (@{$output}, "   Date:        " . $self->ymd);
	push (@{$output}, "   Description: " . $self->description);
	push (@{$output}, "   Url:         " . $self->url);

	return $output;
}

1;

__END__



