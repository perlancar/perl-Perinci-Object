package Perinci::Object::ResMeta;

use 5.010;
use strict;
use warnings;

# VERSION

use parent qw(Perinci::Object::Metadata);

sub type { "resmeta" }

1;
# ABSTRACT: Represent function/method result metadata

=head1 METHODS

=head2 $riresmeta->type => str

Will return C<resmeta>.

