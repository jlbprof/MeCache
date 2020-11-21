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

sub list
{
	my ($self) = @_;

	my $metas = $self->metas;
	my $output = [];

	foreach my $meta (@{$metas})
	{
		push (@{$output}, $meta->get_list_data ());
	}

	return $output;
}

sub get_from_id
{
	my ($self, $id) = @_;

	my $found;
	foreach my $meta (@{$self->metas})
	{
		next if ($id ne $meta->id);
		$found = $meta;
		last;
	}

	return $found;
}

1;

__END__


