package Sub::Spec::Object;

use 5.010;
use strict;
use warnings;

# VERSION

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(ssres);

sub ssres {
    require Sub::Spec::Object::Response;
    Sub::Spec::Object::Response->new(@_);
}

sub ssreq {
    require Sub::Spec::Object::Request;
    Sub::Spec::Object::Request->new(@_);
}

sub ssspec {
    require Sub::Spec::Object::Spec;
    Sub::Spec::Object::Spec->new(@_);
}

sub sssub {
    require Sub::Spec::Object::Sub;
    Sub::Spec::Object::Sub->new(@_);
}

1;
# ABSTRACT: Object-oriented interface for sub/spec/request/response/etc

=head1 SYNOPSIS

 use Sub::Spec::Object;

 my $ssres = ssres [200, "OK", [1, 2, 3]];
 print $ssres->is_success, # 1
       $ssres->status,     # 200
       $ssres->message,    # "OK"
       $ssres->result;     # [1, 2, 3]

 # TODO: ssspec
 # TODO: ssreq
 # TODO: sssub


=head1 DESCRIPTION

L<Sub::Spec> works using pure data structures, but sometimes it's convenient to
have an object-oriented interface for those data. This module provides just
that.


=head1 FUNCTIONS

=head2 ssres $res => OBJECT

Exported by default. A shortcut for Sub::Spec::Object::Response->new($res).


=head1 SEE ALSO

L<Sub::Spec>

=cut
