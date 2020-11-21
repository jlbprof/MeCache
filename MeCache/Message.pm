package MeCache::Message;

use strict;
use warnings;

use Moo;

extends 'MeCache::Meta';

has message => ( 'is' => 'ro' );
has content => ( 'is' => 'ro' );
has content_is_base64 => ( is => 'ro' );

sub init_from_meta
{
	my ($meta) = @_;

	die "Message missing" if (!exists $meta->{'message'});

	my $obj = MeCache::Message->new (
		type => "Message",
		id => $meta->{'filename'},
		created => $meta->{'created'},
		message => $meta->{'message'},
		other => $meta-> {'message'},
		dt => $meta->{'dt'},
		where => $meta->{'where'},
		content => $meta->{'message'},
		content_is_base64 => 0,
	);

	return $obj;
}

sub debug
{
	my ($self) = @_;

	my $debug = $self->SUPER::debug ($self);
	$debug .= " MSG (" . $self->message . ")";

	return $debug;
}

sub get_base_data
{
	my ($self) = @_;

	my $clone = {
		type  => $self->type,
		message => $self->message
	};

	return $clone;
}

sub get_list_formatted
{
	my ($self) = @_;

	my $output = [];

	push (@{$output}, "Message: ID " . $self->id);
	push (@{$output}, "   Message: " . $self->message);

	return $output;
}

1;

__END__



