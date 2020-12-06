package MeCache::Text;

use strict;
use warnings;

use Moo;
use MIME::Base64;

extends 'MeCache::Meta';

has size => ( 'is' => 'ro' );
has language => ( 'is' => 'ro' );
has description => ( 'is' => 'ro' );
has content => ( 'is' => 'ro' );
has content_is_base64 => ( is => 'ro' );

sub init_from_meta
{
	my ($meta) = @_;

	die "Content missing" if (!exists $meta->{'content'});

	my $obj = MeCache::Text->new (
		type => "Text",
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
	$debug .= " Text";

	return $debug;
}

sub first_line
{
	my ($self) = @_;

	my @lines = split ("\n", MIME::Base64::decode_base64 ($self->content));

    return $lines [0];
}

sub summary
{
	my ($self) = @_;

	my $summary = sprintf ("%-8.8s %10.10s %-60.60s", $self->type, $self->dt ()->ymd, $self->first_line);

	return $summary;
}

sub get_base_data
{
	my ($self) = @_;

	my $clone = {
		type  => $self->type,
		content => $self->content,
	};

	return $clone;
}

sub get_list_formatted
{
	my ($self) = @_;

	my $output = [];

	push (@{$output}, "Text: ID " . $self->id);
	push (@{$output}, "   Date:       " . $self->ymd);
	push (@{$output}, "   First Line: " . $self->first_line);

	return $output;
}

1;

__END__



