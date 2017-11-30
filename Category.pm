package Category;

use strict;
use warnings;
use Constants;

sub new {
	my ($class, %option) = @_;

	my $self = {};
	bless $self, $class;
	$self->_init(\%option);

	return $self;
}

sub _init {
	my ($self, $hInput) = @_;

	my %defAttrs = (
		id        => 0,
		name      => '',
		title     => '',
		rating    => 0,
		status    => '',
	);

	while ( my ($attr, $val) = each %defAttrs ) {
		$self->{$attr} = $val;
		if ( ref $hInput eq 'HASH' && exists $hInput->{$attr} ) {
			$self->$attr( $hInput->{$attr} );
		}
	}

	return $self;
}

sub id {
	my ($self, $id) = @_;

	if ( defined $id && $id =~ Constants::RE_INT_UNSIGNED ) {
		$self->{id} = $id;
	}

	return $self->{id};
}

sub name {
	my $self = shift;
	$self->{name} = shift if $_[0];
	return $self->{name};
}

sub title {
	my $self = shift;
	$self->{title} = shift if $_[0];
	return $self->{title};
}

sub rating {
	my ($self, $rating) = @_;

	if ( defined $rating && $rating =~ Constants::RE_INT ) {
		$self->{rating} = $rating;
	}

	return $self->{rating};
}

sub status {
	my $self = shift;
	$self->{status} = shift if $_[0];
	return $self->{status};
}


1;