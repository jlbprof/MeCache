package MeCache::Dir;

use Moo;

has metas => ( is => 'ro' );

sub summary
{
	my ($self) = @_;

	my @summaries;

	foreach my $meta (@{$self->metas})
	{
		push (@summaries, $meta->summary);
	}

	return @summaries;
}

sub summary_heading
{
	my ($self) = @_;

	return if (!@{$self->metas});
	my $meta = $self->metas->[0];

	return $meta->summary_heading;
}

1;

__END__


