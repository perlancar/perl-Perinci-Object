package Perinci::Object::function;

use 5.010;
use strict;
use warnings;

# VERSION

use parent qw(Perinci::Object::Metadata);

sub type { "function" }

# convenience for accessing features property
sub feature {
    my $self = shift;
    my $name = shift;
    if (@_) {
        die "1.0 can't set feature" if $self->v eq 1.0;
        my $value = shift;
        ${$self}->{features} //= {};
        my $old = ${$self}->{features}{$name};
        ${$self}->{features}{$name} = $value;
        return $old;
    } else {
        ${$self}->{features}{$name};
    }
}

# convenience for accessing args property
sub arg {
    my $self = shift;
    my $name = shift;
    if (@_) {
        die "1.0 can't set arg" if $self->v eq 1.0;
        my $value = shift;
        ${$self}->{args} //= {};
        my $old = ${$self}->{args}{$name};
        ${$self}->{args}{$name} = $value;
        return $old;
    } else {
        ${$self}->{args}{$name};
    }
}

1;
# ABSTRACT: Represent function metadata

=head1 SYNOPSIS

 use Sub::Spec::Object::Response;

 $SPEC{foo} = {
     spec_version=>1.1,
     args => { b => {schema=>'int'} },
     features => {undo=>1},
 };
 my $ssspec = ssspec $SPEC{foo};
 print $ssres->feature('undo'), # 1
       $ssres->arg('a');        # undef


=head1 DESCRIPTION

This class provides an object-oriented interface for sub spec.


=head1 METHODS

=head2 new($spec) => OBJECT

Create a new object from $spec. If $spec is undef, creates an empty spec.

=head2 $ssspec->feature(NAME[, VALUE])

Get or set named feature (B<features> key in spec). If a feature doesn't exist,
undef will be returned.

=head2 $ssres->arg(NAME[, VALUE])

Get or set argument (B<args> key in spec). If an argument doesn't exist, undef
will be returned.


=head1 SEE ALSO

L<Sub::Spec::Object>

=cut
