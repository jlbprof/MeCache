package MeCache::File;

use strict;
use warnings;

use Moo;

extends 'MeCache::Meta';

has name => ( 'is' => 'ro' );
has size => ( 'is' => 'ro' );
has content => ( 'is' => 'ro' );

sub init_from_meta
{
	my ($meta) = @_;

	die "Name missing" if (!exists $meta->{'name'});
	die "Size missing" if (!exists $meta->{'size'});
	die "Content missing" if (!exists $meta->{'content'});

	my $obj = MeCache::File->new (
		type => "File",
		filename => $meta->{'filename'},
		created => $meta->{'created'},
		name => $meta->{'name'},
		content => $meta-> {'content'},
		size => $meta-> {'size'},
		dt => $meta->{'dt'},
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

sub clone_essentials
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

1;

__END__



