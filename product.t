#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests => 16;


my $class = 'Product';

use_ok($class);

require_ok($class);

my $oProduct = $class->new();
isa_ok($oProduct, $class);

can_ok( $oProduct, 'id' );
my $idBad = 'bad';
is( $oProduct->id($idBad), 0, 'Product id must be a digit.' );

my $idGood = 123;
ok( $oProduct->id($idGood) == $idGood, 'Product id is the same digit.' );


can_ok( $oProduct, 'sku' );

can_ok( $oProduct, 'name' );

can_ok( $oProduct, 'title' );

can_ok( $oProduct, 'cost' );

can_ok( $oProduct, 'discount' );

can_ok( $oProduct, 'quantity' );

can_ok( $oProduct, 'rating' );

can_ok( $oProduct, 'option' );

can_ok( $oProduct, 'options' );

can_ok( $oProduct, 'price' );