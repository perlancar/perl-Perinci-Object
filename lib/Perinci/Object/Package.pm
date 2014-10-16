package Perinci::Object::Package;

use 5.010;
use strict;
use warnings;

# VERSION

use parent qw(Perinci::Object::Metadata);

sub type { "package" }

1;
# ABSTRACT: Represent package metadata

=head1 METHODS

=head2 $ripkg->type => str

Will return C<package>.

