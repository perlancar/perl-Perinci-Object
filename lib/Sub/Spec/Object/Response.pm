package Sub::Spec::Object::Response;

use 5.010;
use strict;
use warnings;

# VERSION

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(ssres);

sub new {
    my ($class, $res) = @_;
    $res //= [0, "", undef];
    my $obj = \$res;
    bless $obj, $class;
}

sub status {
    my ($self, $new) = @_;
    if (defined $new) {
        my $old = ${$self}->[0];
        ${$self}->[0] = $new;
        return $old;
    }
    ${$self}->[0];
}

sub message {
    my ($self, $new) = @_;
    if (defined $new) {
        my $old = ${$self}->[1];
        ${$self}->[1] = $new;
        return $old;
    }
    ${$self}->[1];
}

sub result {
    my ($self, $new) = @_;
    if (defined $new) {
        my $old = ${$self}->[2];
        ${$self}->[2] = $new;
        return $old;
    }
    ${$self}->[2];
}

sub is_success {
    my ($self) = @_;
    my $status = ${$self}->[0];
    $status >= 200 && $status <= 299;
}

1;
# ABSTRACT: Represent sub response

=head1 SYNOPSIS

 use Sub::Spec::Object::Response;

 my $ssres = Sub::Spec::Object::Response->new([200, "OK", [1, 2, 3]]);
 print $ssres->is_success, # 1
       $ssres->status,     # 200
       $ssres->message,    # "OK"
       $ssres->result;     # [1, 2, 3]


=head1 DESCRIPTION

This class provides an object-oriented interface for sub response.


=head1 METHODS

=head2 new($res) => OBJECT

Create a new object from $res response data.

=head2 $ssres->status

Get or set status.

=head2 $ssres->message

Get or set message.

=head2 $ssres->is_success

True if status is between 200-299.


=head1 SEE ALSO

L<Sub::Spec::Object>

=cut
