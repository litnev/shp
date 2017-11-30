package ShippingMethod;

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
		id                => 0,
		name              => '',
		title             => '',
		status            => '',
		cost              => 0,
		min_delivery_days => 0,
		max_delivery_days => 0,
	);

	while ( my ($attr, $val) = each %defAttrs ) {
		$self->{$attr} = $val;
		next if $attr =~ /^_/;
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

sub status {
	my $self = shift;
	$self->{status} = shift if $_[0];
	return $self->{status};
}

sub minDeliveryDays {
	my ($self, $days) = @_;

	if ( $days && $days =~ Constants::RE_INT_UNSIGNED ) {
		my $maxDays = $self->maxDeliveryDays;
		$self->{min_delivery_days} = $days if $maxDays <= $days;
	}

	return $self->{min_delivery_days};
}

sub maxDeliveryDays {
	my ($self, $days) = @_;

	if ( $days && $days =~ Constants::RE_INT_UNSIGNED ) {
		my $minDays = $self->minDeliveryDays;
		$self->{max_delivery_days} = $days if $minDays <= $days;
	}

	return $self->{max_delivery_days};
}

sub cost {
	my ($self, $cost) = @_;

	if ( $cost && $cost =~ Constants::RE_INT_UNSIGNED ) {
		$self->{cost} = $cost;
	}

	return $self->{cost};
}


1;