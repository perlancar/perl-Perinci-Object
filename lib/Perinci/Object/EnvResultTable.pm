package Perinci::Object::EnvResultTable;

# DATE
# VERSION

use 5.010;
use strict;
use warnings;

use parent qw(Perinci::Object::EnvResult);

sub add_field {
    my ($self, $name, %attrs) = @_;
    ${$self}->[3]{'table.fields'} //= [];
    push @{ ${$self}->[3]{'table.fields'} }, $name;
}

1;
# ABSTRACT: Represent enveloped result (table)

=head1 SYNOPSIS

 use Perinci::Object::EnvResultTable;

 sub myfunc {
     ...

     my $envres = Perinci::Object::EnvResultTable->new;

     # add fields
     $envres->add_field('foo');
     $envres->add_field('foo');

     # finally, return the result
     return $envres->as_struct;
 }


=head1 DESCRIPTION

This class is a subclass of L<Perinci::Object::EnvResult> and provides
convenience methods when you want to return table data.


=head1 METHODS

=head2 new($res) => OBJECT

Create a new object from C<$res> enveloped result array.

=head2 $envres->add_field($name, %attrs)

Add a table field. This will create/push an entry to the C<table.fields> result
metadata array.


=head1 SEE ALSO

L<Perinci::Object>

L<Perinci::Object::EnvResult>

=cut
