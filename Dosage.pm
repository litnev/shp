package Dosage;

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
		id   => 0,
		name => '',
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



1;