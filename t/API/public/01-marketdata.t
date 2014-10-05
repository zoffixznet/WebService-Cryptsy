#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;
use Test::Deep;

plan tests => 1;

use WebService::Cryptsy;

my $cryp = WebService::Cryptsy->new( timeout => 10 );
diag "This test fetches quite a bit of data, so it may take some time to complete.";
my $data = $cryp->marketdata;
if ( $data ) {
    cmp_deeply(
        $data,
        {
            markets => hash_each(
                {
                    'primaryname' => re('.'),
                    'volume' => re('^[-+.\d]+$'),
                    'lasttradeprice' => re('^[-+.\d]+$'),
                    'marketid' => re('^\d+$'),
                    'secondarycode' => re('.'),
                    'primarycode' => re('.'),
                    'lasttradetime' => re('.'),
                    'label' => re('.'),
                    'secondaryname' => re('.'),
                    'buyorders' => any(
                        array_each(
                            {
                                'quantity' => re('^[-+.\d]+$'),
                                'price' => re('^[-+.\d]+$'),
                                'total' => re('^[-+.\d]+$'),
                            },
                        ),
                        undef,
                    ),
                    'sellorders' => any(
                        array_each(
                            {
                                'quantity' => re('^[-+.\d]+$'),
                                'price' => re('^[-+.\d]+$'),
                                'total' => re('^[-+.\d]+$'),
                            },
                        ),
                        undef,
                    ),
                    'recenttrades' => any(
                        array_each(
                            {
                                'quantity' => re('^[-+.\d]+$'),
                                'price' => re('^[-+.\d]+$'),
                                'total' => re('^[-+.\d]+$'),
                                'id' => re('.'),
                                'time' => re('.'),
                                'type' => re('.'),
                            },
                        ),
                        undef,
                    ),
                }
            ),
        },
        '->marketdata returned an expected hashref'
    );
}
else {
    diag "Got an error getting an API request: $cryp";
    ok( length $cryp->error );
}