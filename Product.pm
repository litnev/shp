package Product;

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
		id          => 0,
		name        => '',
		title       => '',
		rating      => 0,
		status      => '',
		type        => '',
		flag        => '',
		label_color => undef,
		label_text  => undef,
		_items      => {},
		_categories => {},
		_suppliers  => {},
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

sub type {
	my $self = shift;
	$self->{type} = shift if $_[0];
	return $self->{type};
}

sub flag {
	my $self = shift;
	$self->{flag} = shift if defined $_[0];
	return $self->{flag};
}

sub labelColor {
	my $self = shift;
	$self->{label_color} = shift if $_[0];
	return $self->{label_color};
}

sub labelText {
	my $self = shift;
	$self->{label_text} = shift if $_[0];
	return $self->{label_text};
}

sub firstLetter {
	return  lc( substr shift->{title}, 0, 1 );
}

# items
sub getItems {
	my ($self, %options) = @_;
	return $self->_getObjects('_items', \%options);
}

sub addItems {
	my $self = shift;
	my @inputObjects = ref $_[0] eq 'ARRAY' ? @{ +shift } : @_;
	return $self->_addObjects('_items', \@inputObjects);
}

sub delItems {
	my ($self, %options) = @_;
	return $self->_delObjects('_items', \%options);
}

# categories
sub getCategories {
	my ($self, %options) = @_;
	return $self->_getObjects('_categories', \%options);
}

sub addCategories {
	my $self = shift;
	my @inputObjects = ref $_[0] eq 'ARRAY' ? @{ +shift } : @_;
	return $self->_addObjects('_categories', \@inputObjects);
}

sub delCategories {
	my ($self, %options) = @_;
	return $self->_delObjects('_categories', \%options);
}

# suppliers
sub getSuppliers {
	my ($self, %options) = @_;
	return $self->_getObjects('_suppliers', \%options);
}

sub addSuppliers {
	my $self = shift;
	my @inputObjects = ref $_[0] eq 'ARRAY' ? @{ +shift } : @_;
	return $self->_addObjects('_suppliers', \@inputObjects);
}

sub delSuppliers {
	my ($self, %options) = @_;
	return $self->_delObjects('_suppliers', \%options);
}

# private methods
sub _getObjects {
	my ($self, $objName, $hOptions) = @_;

	unless ( $objName && exists $self->{$objName} && ref $self->{$objName} eq 'HASH' ) {
		die "Counstructor doesn't contain object '$objName'.";
	}

	my @objects = values %{ $self->{$objName} };
	my $patterns = keys %$hOptions;

	# return all unless options or exists option 'all'
	if ( !$patterns || delete $hOptions->{all} ) {
		return @objects;
	}
	# fast return if options contain only 'id'
	elsif ( $patterns == 1 && exists $hOptions->{id} ) {
		return ( $self->{$objName}{ $hOptions->{id} } );
	}

	my @outObjects;
	foreach my $oObject (@objects) {
		my $matches = 0;
		while ( my($sub, $arg) = each %$hOptions ) {
			next unless $sub && $sub !~ /^_/ && $oObject->can($sub);
			$matches++ if $oObject->$sub() eq $arg;
		}
		push @outObjects, $oObject if $patterns == $matches;
	}

	return @outObjects;
}

sub _addObjects {
	my ($self, $objName, $aObjects) = @_;

	my $added = 0;
	foreach my $oObject (@$aObjects) {
		next unless UNIVERSAL::can($oObject, 'isa') && $oObject->can('id');

		# 'id' is unique field
		my $id = $oObject->id;
		next if exists $self->{$objName}{$id};

		$self->{$objName}{$id} = $oObject;
		$added++;
	}

	return $added;
}

sub _delObjects {
	my ($self, $objName, $hOptions) = @_;

	( my $sub = $objName ) =~ s/^_(.+)$/get\u$1/;

	my @objects = $self->$sub();
	if ( !%$hOptions || delete $hOptions->{all} ) {
		$self->{$objName} = {};
		return scalar @objects;
	}

	my $deleted = 0;
	foreach my $oObject ( $self->$sub(%$hOptions) ) {
		delete $self->{$objName}{ $oObject->id };
		$deleted++;
	}

	return $deleted;
}


1;