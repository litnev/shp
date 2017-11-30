package Item;

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
		id           => 0,
		sku          => '',
		cost         => 0,
		discount     => 0,
		max_discount => 0,
		rating       => 0,
		status       => '',
		quntity      => 1,
		flag         => '',
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

sub sku {
	my $self = shift;
	$self->{sku} = shift if $_[0];
	return $self->{sku};
}

sub cost {
	my ($self, $cost) = @_;

	if ( defined $cost && $cost =~ Constants::RE_FLOAT ) {
		$self->{cost} = $cost;
	}

	return $self->{cost};
}

sub discount {
	my ($self, $discount) = @_;
	
	if ( defined $discount && $discount =~ Constants::RE_FLOAT ) {
		my $maxDiscount = $self->discount;
		$self->{discount} = $discount > $maxDiscount ? $maxDiscount : $discount;
	}

	return $self->{discount};
}

sub maxDiscount {
	my ($self, $maxDiscount) = @_;

	if ( defined $maxDiscount && $maxDiscount =~ Constants::RE_FLOAT ) {
		$self->{max_disount} = $maxDiscount;
	}

	return $self->{max_discount};
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

sub quantity {
	my ($self, $quantity) = @_;

	if ( $quantity && $quantity =~ Constants::RE_INT ) {
		$self->{quantity} = $quantity;
	}

	return $self->{quntity};
}

sub flag {
	my $self = shift;
	$self->{flag} = shift if defined $_[0];
	return $self->{flag};
}

sub price {
	my ($self, $witDiscount) = @_;
	my $price = $self->cost * $self->quantity;
	$price *= (1 - 0.01 * $self->discount) if $witDiscount;
	return sprintf '%.2f', $price;	
}


1;