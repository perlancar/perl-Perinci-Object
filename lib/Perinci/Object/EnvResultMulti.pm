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

sub add_response {
    my ($self, $status, $message, $extra) = @_;
    my $num_ok  = 0;
    my $num_nok = 0;

    push @{ ${$self}->[3]{responses} },
        {%{ $extra // {} }, status=>$status, message=>$message};
    for (@{ ${$self}->[3]{responses} // [] }) {
        if ($_->{status} =~ /\A2/) {
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
            ${$self}->[0] = 200;
            ${$self}->[1] = "All success";
        }
    } else {
        ${$self}->[0] = $status;
        ${$self}->[1] = $message;
    }
}

1;
# ABSTRACT: Represent enveloped result (multistatus response)

=head1 SYNOPSIS

 use Perinci::Object::EnvResultMulti;
 use Data::Dump; # for dd()

 sub myfunc {
     ...

     # if unspecified, the default response will be [200, "Success/no items"]
     my $envres = Perinci::Object::EnvResultMulti->new;

     # then you can add response for each item
     $envres->add_response(200, "OK", {item_id=>1});
     $envres->add_response(202, "OK", {item_id=>2, note=>"blah"});
     $envres->add_response(404, "Not found", {item_id=>3});
     ...

     # if you add a success status, the overall status will still be 200

     # if you add a non-success staus, the overall status will be 207, or
     # the non-success status (if no success has been added)

     # finally, return the result
     return $envres->as_struct;

     # the result from the above will be: [207, "Partial success", undef,
     # {responses => [
     #     {success=>200, message=>"OK", item_id=>1},
     #     {success=>201, message=>"OK", item_id=>2, note=>"blah"},
     #     {success=>404, message=>"Not found", item_id=>3},
     # ]}]
 } # myfunc


=head1 DESCRIPTION

This class is a subclass of L<Perinci::Object::EnvResult> and provide a
convenience method when you want to use multistatus/detailed per-item responses
(specified in L<Rinci> 1.1.63). In this case, response status can be 200, 207,
or non-success. As you add more per-item responses, this class will set/update
the overall response status for you.


=head1 METHODS

=head2 new($res) => OBJECT

Create a new object from C<$res> enveloped result array. If C<$res> is not
specified, the default is C<< [200, "Success/no items"] >>.

=head2 $envres->add_response($status, $message, \%extra)

Add an item response.


=head1 SEE ALSO

L<Perinci::Object>

L<Perinci::Object::EnvResult>

=cut
