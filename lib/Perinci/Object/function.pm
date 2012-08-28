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

 use Perinci::Object::Response;

 $SPEC{foo} = {
     v        => 1.1,
     args     => { b => {schema=>'int', req=>0} },
     features => {idempotent=>1},
 };
 my $risub = risub $SPEC{foo};
 print $risub->feature('idempotent'), # 1
       $risub->arg('b')->{req},       # 0
       $risub->arg('a');              # undef


=head1 DESCRIPTION

This class provides an object-oriented interface for function metadata.


=head1 METHODS

=head2 new($meta) => OBJECT

Create a new object from $meta. If $meta is undef, creates an empty metadata.

=head2 $risub->feature(NAME[, VALUE])

Get or set named feature (B<features> property in metadata). If a feature
doesn't exist, undef will be returned.

=head2 $risub->arg(NAME[, VALUE])

Get or set argument (B<args> property in metadata). If an argument doesn't
exist, undef will be returned.


=head1 SEE ALSO

L<Perinci::Object>

=cut
