#!/usr/bin/env perl

use strict;
use warnings;
use lib qw(../lib lib);

use WebService::Cryptsy;
use Data::Dumper;


my $pub_key = '';
my $priv_key = '';


my $cryp = WebService::Cryptsy->new(
    pub_key => $pub_key,
    priv_key => $priv_key,
);

print Dumper( $cryp->getinfo ) . "\n";

print Dumper( $cryp->marketdata ) . "\n";







