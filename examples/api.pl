#!/usr/bin/env perl

use strict;
use warnings;
use lib qw(../lib lib);

use WebService::Cryptsy;

my $pub_key = '479c5cbd116f8f5972bdaf12dd0a3f82562c8a7c';
my $priv_key = 'b408e899526142ac613304669a657c8782435ccda2f65dbea05270fe8dfa5d3d2ef7eb4812ce1c35';


my $cryp = WebService::Cryptsy->new(
    pub_key => $pub_key,
    priv_key => $priv_key,
);

print $cryp->getinfo . "\n";





