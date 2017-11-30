package Product::Type::Pharmacy;

use strict;
use warnings;

use parent 'Product';

sub _init {
	my ($self, $hInput) = @_;

	$self->SUPER::_init($hInput);
	$self->SUPER::type('pharma');
	$self->container( $hInput->{container} || 'pill' );

	return $self;
}

sub type { shift->{type} }

sub container {
	my $self = shift;
	$self->{container} = shift if $_[0];
	return $self->{container};
}


1;