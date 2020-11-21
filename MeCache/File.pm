package MeCache::File;

use strict;
use warnings;

use Moo;

extends 'MeCache::Meta';

has name => ( 'is' => 'ro' );
has size => ( 'is' => 'ro' );
has content => ( 'is' => 'ro' );
has content_is_base64 => ( is => 'ro' );

sub init_from_meta
{
	my ($meta) = @_;

	die "Name missing" if (!exists $meta->{'name'});
	die "Size missing" if (!exists $meta->{'size'});
	die "Content missing" if (!exists $meta->{'content'});

	my $obj = MeCache::File->new (
		type => "File",
		id => $meta->{'filename'},
		created => $meta->{'created'},
		name => $meta->{'name'},
		content => $meta-> {'content'},
		size => $meta-> {'size'},
		dt => $meta->{'dt'},
		where => $meta->{'where'},
		content_is_base64 => 1
	);

	return $obj;
}

sub debug
{
	my ($self) = @_;

	my $debug = $self->SUPER::debug ($self);
	$debug .= " File (" . $self->name . ")";

	return $debug;
}

sub summary
{
	my ($self) = @_;

	my $summary = sprintf ("%-8.8s %10.10s %-68.68s", $self->type, $self->dt ()->ymd, $self->name);

	return $summary;
}

sub get_base_data
{
	my ($self) = @_;

	my $clone = {
		type  => $self->type,
		name => $self->name,
		size => $self->size,
		content => $self->content,
	};

	return $clone;
}

sub get_list_formatted
{
	my ($self) = @_;

	my $output = [];

	push (@{$output}, "File: ID " . $self->id);
	push (@{$output}, "   Filename: " . $self->name);
	push (@{$output}, "   Size:     " . $self->size);

	return $output;
}

1;

__END__



