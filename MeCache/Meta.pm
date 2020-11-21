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
		filename => $meta->{'filename'},
		created => $meta->{'created'},
		other => $meta->{'other'},
		dt => $meta->{'dt'},
	);

	return $obj;
}

has filename => (
	is => 'ro'
);

has type => ( is => 'ro', default => 'UNKNOWN' );
has created => ( is => 'ro' );
has other => ( is => 'ro', default => '');
has dt => ( is => 'ro' );

sub debug
{
	my ($self) = @_;

	my $debug = $self->type . ":" . "CREATED (" . $self->created . ")" . " File (" . $self->filename . ")";

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

sub clone_essentials
{
	my ($self) = @_;

	my $clone = {
		type  => $self->type,
		other => $self->other
	};

	return $clone;
}

1;

__END__


