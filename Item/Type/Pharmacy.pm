package Item::Type::Pharmacy;

use strict;
use warnings;

use parent 'Item';

sub _init {
	my ($self, $hInput) = @_;
	
	$self->{quantity} = 0;
	
	$self->SUPER::_init($hInput);
	$self->quantity( $hInput->{quantity} );
	return $self;
}

sub quantity {
	my ($self, $quantity) = @_;
	if ( $quantity && $quantity =~ Constants::RE_INT_UNSIGNED ) {
		$self->{quantity} = $quantity;
	}
	return $self->{quantity};
}


1;