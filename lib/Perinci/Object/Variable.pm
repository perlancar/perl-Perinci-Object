package Perinci::Object::Variable;

# DATE
# VERSION

use 5.010;
use strict;
use warnings;

use parent qw(Perinci::Object::Metadata);

sub type { "variable" }

1;
# ABSTRACT: Represent variable metadata

=head1 METHODS

=head2 $rivar->type => str

Will return C<variable>.
