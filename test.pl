#!/usr/bin/env perl
use strict;
use warnings;

use Product::Type::Pharmacy;
use Item;
use Category;
use Supplier;
use ShippingMethod;

use Data::Dumper;

my $oProduct  = Product::Type::Pharmacy->new(id=>1, name=>'product');
my $oItem1 = Item->new(id=>1, sku=>'123456ww');
my $oItem2 = Item->new(id=>2, sku=>'123456ss');
$oProduct->addItems($oItem1, $oItem2);
$oProduct->delItems(id=>'2');

my $oCategory = Category->new(id=>2, name=>"category");
$oProduct->addCategories($oCategory);

my $oSupplier = Supplier->new(id=>3, name=>'supplier');
$oProduct->addSuppliers($oSupplier);

my $oShippingMethod = ShippingMethod->new(id=>1, name=>'shipping_method');
$oSupplier->addShippingMethods($oShippingMethod);

print Dumper $oProduct;


