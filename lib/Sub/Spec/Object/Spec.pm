package Sub::Spec::Object::Spec;

use 5.010;
use strict;
use warnings;

# VERSION

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(ssspec);

sub new {
    my ($class, $spec) = @_;
    $spec //= {};
    my $obj = \$spec;
    bless $obj, $class;
}

sub spec_version {
    my $self = shift;
    ${$self}->{spec_version} // 1.0;
}

sub feature {
    my $self = shift;
    my $name = shift;
    if (@_) {
        my $value = shift;
        ${$self}->{features} //= {};
        my $old = ${$self}->{features}{$name};
        ${$self}->{features}{$name} = $value;
        return $old;
    } else {
        ${$self}->{features}{$name};
    }
}

sub arg {
    my $self = shift;
    my $name = shift;
    if (@_) {
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
# ABSTRACT: Represent sub spec

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
