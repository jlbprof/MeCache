package MeCache::CodeSnippet;

use strict;
use warnings;

use Moo;

extends 'MeCache::Meta';

has size => ( 'is' => 'ro' );
has language => ( 'is' => 'ro' );
has description => ( 'is' => 'ro' );
has content => ( 'is' => 'ro' );
has content_is_base64 => ( is => 'ro' );

sub init_from_meta
{
	my ($meta) = @_;

	die "Language missing" if (!exists $meta->{'language'});
	die "Description missing" if (!exists $meta->{'description'});
	die "Content missing" if (!exists $meta->{'content'});

	my $obj = MeCache::CodeSnippet->new (
		type => "CodeSnippet",
		id => $meta->{'filename'},
		created => $meta->{'created'},
		name => $meta->{'name'},
		content => $meta-> {'content'},
		size => $meta-> {'size'},
		dt => $meta->{'dt'},
		where => $meta->{'where'},
		language => $meta->{'language'},
		description => $meta->{'description'},
		content_is_base64 => 1
	);

	return $obj;
}

sub debug
{
	my ($self) = @_;

	my $debug = $self->SUPER::debug ($self);
	$debug .= " CodeSnippet (" . $self->language . ", " . $self->description . ")";

	return $debug;
}

sub summary
{
	my ($self) = @_;

	my $summary = sprintf ("%-8.8s %10.10s %10.10s %-50.50s", $self->type, $self->dt ()->ymd, $self->language, $self->description);

	return $summary;
}

sub get_base_data
{
	my ($self) = @_;

	my $clone = {
		type  => $self->type,
		language => $self->language,
		description => $self->description,
		content => $self->content,
	};

	return $clone;
}

sub get_list_formatted
{
	my ($self) = @_;

	my $output = [];

	push (@{$output}, "CodeSnippet: ID " . $self->id);
	push (@{$output}, "   Date:       " . $self->ymd);
	push (@{$output}, "   Language:   " . $self->language);
	push (@{$output}, "   Description:" . $self->description);

	return $output;
}

1;

__END__



