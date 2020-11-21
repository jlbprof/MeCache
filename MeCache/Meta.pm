package MeCache::Meta;

use Moo;
use Path::Tiny;
use File::chdir;
use Cpanel::JSON::XS;
use DateTime;

use Data::Dumper;

sub init_from_meta
{
	my ($meta) = @_;

	$meta->{'other'} //= "";

	my $obj = MeCache::Meta->new (
		type => $meta->{'type'},
		id => $meta->{'filename'},
		created => $meta->{'created'},
		other => $meta->{'other'},
		dt => $meta->{'dt'},
		where => $meta->{'where'},
		content => $meta->{'other'},
		content_is_base64 => 0,
	);

	return $obj;
}

has id => ( is => 'ro');
has type => ( is => 'ro', default => 'UNKNOWN' );
has created => ( is => 'ro' );
has other => ( is => 'ro', default => '');
has dt => ( is => 'ro' );
has where => ( is => 'ro' );
has content => ( is => 'ro' );
has content_is_base64 => ( is => 'ro' );

sub debug
{
	my ($self) = @_;

	my $debug = $self->type . ":" . "CREATED (" . $self->created . ")" . " File (" . $self->id . ")";

	return $debug;
}

sub summary
{
	my ($self) = @_;

	my $summary = sprintf ("%-8.8s %10.10s %-68.68s", $self->type, $self->dt ()->ymd, $self->other);

	return $summary;
}

sub summary_heading
{
	my ($self) = @_;

	# 2020-10-24
	# 01234567890

	my $heading = sprintf ("%-8.8s %10.10s %-58.58s", "Type", "Date", "Summary");

	return $heading;
}

sub get_base_data
{
	my ($self) = @_;

	my $clone = {
		type  => $self->type,
		other => $self->other
	};

	return $clone;
}

sub get_list_data
{
	my ($self) = @_;

	my $clone = $self->get_base_data ();
	$clone->{'id'} = $self->id;
	$clone->{'where'} = $self->where;

	return $clone;
}

sub get_list_formatted
{
	my ($self) = @_;

	my $output = [];

	push (@{$output}, "Meta: ID " . $self->id);
	push (@{$output}, "   Other: " . $self->other);

	return $output;
}

1;

__END__


