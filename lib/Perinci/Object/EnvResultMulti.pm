package Perinci::Object::EnvResultMulti;

# DATE
# VERSION

use 5.010;
use strict;
use warnings;

use parent qw(Perinci::Object::EnvResult);

sub new {
    my ($class, $res) = @_;
    $res //= [200, "Success/no items"];
    my $obj = \$res;
    bless $obj, $class;
}

sub add_result {
    my ($self, $status, $message, $extra) = @_;
    my $num_ok  = 0;
    my $num_nok = 0;

    push @{ ${$self}->[3]{results} },
        {status=>$status, message=>$message, %{ $extra // {} }};
    for (@{ ${$self}->[3]{results} // [] }) {
        if ($_->{status} =~ /\A(2|304)/) {
            $num_ok++;
        } else {
            $num_nok++;
        }
    }
    if ($num_ok) {
        if ($num_nok) {
            ${$self}->[0] = 207;
            ${$self}->[1] = "Partial success";
        } else {
            my $overall_status = 200;
            my %statuses;
            for (@{ ${$self}->[3]{results} // []}) {
                $statuses{ $_->{status} }++;
            }
            if (keys %statuses == 1) {
                my @tmp = keys %statuses;
                $overall_status = $tmp[0];
            }
            ${$self}->[0] = $overall_status;
            ${$self}->[1] = "All success";
        }
    } else {
        ${$self}->[0] = $status;
        ${$self}->[1] = $message;
    }
}

1;
# ABSTRACT: Represent enveloped result (multistatus)

=head1 SYNOPSIS

 use Perinci::Object::EnvResultMulti;
 use Data::Dump; # for dd()

 sub myfunc {
     ...

     # if unspecified, the default status will be [200, "Success/no items"]
     my $envres = Perinci::Object::EnvResultMulti->new;

     # then you can add result for each item
     $envres->add_result(200, "OK", {item_id=>1});
     $envres->add_result(202, "OK", {item_id=>2, note=>"blah"});
     $envres->add_result(404, "Not found", {item_id=>3});
     ...

     # if you add a success status, the overall status will still be 200

     # if you add a non-success staus, the overall status will be 207, or
     # the non-success status (if no success has been added)

     # finally, return the result
     return $envres->as_struct;

     # the result from the above will be: [207, "Partial success", undef,
     # {results => [
     #     {success=>200, message=>"OK", item_id=>1},
     #     {success=>201, message=>"OK", item_id=>2, note=>"blah"},
     #     {success=>404, message=>"Not found", item_id=>3},
     # ]}]
 } # myfunc


=head1 DESCRIPTION

This class is a subclass of L<Perinci::Object::EnvResult> and provides a
convenience method when you want to use multistatus/detailed per-item results
(specified in L<Rinci> 1.1.63: C<results> result metadata property). In this
case, response status can be 200, 207, or non-success. As you add more per-item
results, this class will set/update the overall response status for you.


=head1 METHODS

=head2 new($res) => OBJECT

Create a new object from C<$res> enveloped result array. If C<$res> is not
specified, the default is C<< [200, "Success/no items"] >>.

=head2 $envres->add_result($status, $message, \%extra)

Add an item result.


=head1 SEE ALSO

L<Perinci::Object>

L<Perinci::Object::EnvResult>

=cut
