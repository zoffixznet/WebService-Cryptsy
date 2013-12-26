package WebService::Cryptsy;

use Moo;
use WWW::Mechanize;
use JSON::MaybeXS;
use Digest::SHA qw/hmac_sha512_hex/;
use HTTP::Request;
use Data::Dumper;
our $VERSION = '0.01';
use constant API_URL => 'https://www.cryptsy.com/api';

has pub_key => ( is => 'ro', required => 1 );
has priv_key => ( is => 'ro', required => 1 );

sub _nonce {
    my $self = shift;
    return ++$self->{ZOF_NONCE};
}

sub getinfo {
    my $self = shift;

    return $self->api_query('getinfo');
}

sub api_query {
    my ( $self, $method, %req ) = @_;

    $req{method} = $method;
    $req{nonce}  = $self->_nonce;
    my @data;
    for ( keys %req ) {
        push @data, $_ . '=' . $req{$_};
    }

    my $digest = hmac_sha512_hex(join('&', @data), $self->priv_key);

    my $ua = WWW::Mechanize->new( timeout => 30 );

    my $res = $ua->post(
        API_URL,
        Content => join('&', @data),
        Key     => $self->pub_key,
        Sign    => $digest,
    );

    return $res->decoded_content;
}


1;

__END__

=encoding utf8

=head1 NAME

WebService::Cryptsy - The great new WebService::Cryptsy!

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use WebService::Cryptsy;

    my $foo = WebService::Cryptsy->new();
    ...

=head1 AUTHOR

Zoffix Znet, C<< <zoffix at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-webservice-cryptsy at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WebService-Cryptsy>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WebService::Cryptsy


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WebService-Cryptsy>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WebService-Cryptsy>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WebService-Cryptsy>

=item * Search CPAN

L<http://search.cpan.org/dist/WebService-Cryptsy/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2013 Zoffix Znet.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

