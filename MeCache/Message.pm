package MeCache::Message;

use strict;
use warnings;

use Moo;

extends 'MeCache::Meta';

has message => ( 'is' => 'ro' );

sub init_from_meta
{
	my ($meta) = @_;

	die "Message missing" if (!exists $meta->{'message'});

	my $obj = MeCache::Message->new (
		type => "Message",
		filename => $meta->{'filename'},
		created => $meta->{'created'},
		message => $meta->{'message'},
		other => $meta-> {'message'},
		dt => $meta->{'dt'},
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

sub clone_essentials
{
	my ($self) = @_;

	my $clone = {
		type  => $self->type,
		message => $self->message
	};

	return $clone;
}

1;

__END__



