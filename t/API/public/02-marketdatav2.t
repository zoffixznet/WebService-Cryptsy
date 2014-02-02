#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;
use Test::Deep;

plan tests => 1;

use WebService::Cryptsy;

my $cryp = WebService::Cryptsy->new( timeout => 10 );

my $data = $cryp->marketdatav2;
if ( $data ) {
    cmp_deeply(
        $data,
        {
            markets => hash_each(
                {
                    'primaryname' => re('.'),
                    'secondaryname' => re('.'),
                    'label' => re('.'),
                    'volume' => re('^[-+.\d]+$'),
                    'lasttradeprice' => re('^[-+.\d]+$'),
                    'marketid' => re('^\d+$'),
                    'primarycode' => re('.'),
                    'secondarycode' => re('.'),
                    'lasttradetime' => re('.'),
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
                    'recenttrades' => any(
                        array_each(
                            {
                                'time' => re('.'),
                                'quantity' => re('^[-+.\d]+$'),
                                'price' => re('^[-+.\d]+$'),
                                'id' => re('^[-+.\d]+$'),
                                'total' => re('^[-+.\d]+$'),
                            },
                        ),
                        undef,
                    ),
                },
            ),
        },
        '->marketdatav2 returns an expected hashref',
    );
}
else {
    diag "Got an error getting an API request: $cryp";
    ok( length $cryp->error );
}