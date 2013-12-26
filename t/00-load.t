#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'WebService::Cryptsy' ) || print "Bail out!\n";
}

diag( "Testing WebService::Cryptsy $WebService::Cryptsy::VERSION, Perl $], $^X" );
