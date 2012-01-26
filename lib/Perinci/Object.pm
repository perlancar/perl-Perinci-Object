package Perinci::Object;

use 5.010;
use strict;
use warnings;

# VERSION

require Exporter;
our @ISA    = qw(Exporter);
our @EXPORT = qw(risub rivar ripkg rires);

sub risub {
    require Perinci::Object::function;
    Perinci::Object::function->new(@_);
}

sub rivar {
    require Perinci::Object::variable;
    Perinci::Object::variable->new(@_);
}

sub ripkg {
    require Perinci::Object::package;
    Perinci::Object::package->new(@_);
}

sub rires {
    require Perinci::Object::Result;
    Perinci::Object::Result->new(@_);
}

1;
# ABSTRACT: Object-oriented interface for Rinci-related data structures

=head1 SYNOPSIS

 use Perinci::Object; # automatically exports risub(), rivar(), ripkg(), rires()
 use Data::Dump; # for dd()

 # OO interface to function metadata. supports Rinci 1.1 specification as well
 # as old Sub::Spec 1.0 (will convert to 1.1).

 my $risub = risub {
     summary => 'Foo',
     args => { a1 => 'int*', a2 => [str=>{default=>'a'}] },
     features => { pure=>1 },
 };
 dd $risub->type,             # "function"
    $risub->v,                # 1.0
    $risub->arg('a1'),        # { schema=>'int*' }
    $risub->arg('a3'),        # undef
    $risub->feature('pure'),  # 1
    $risub->feature('foo');   # undef

 # setting arg and property
 $risub->arg('a3', 'array');  # will actually fail for 1.0 metadata
 $risub->feature('foo', 2);   # ditto

 # OO interface to variable metadata

 my $rivar = rivar { ... };

 # OO interface to package metadata

 my $ripkg = ripkg { ... };

 # OO interface to enveloped result

 my $rires = rires [200, "OK", [1, 2, 3]];
 dd $rires->is_success, # 1
    $rires->status,     # 200
    $rires->message,    # "OK"
    $rires->result,     # [1, 2, 3]
    $rires->extra;      # undef

 # setting status, message, result, extra
 $rires->status(404);
 $rires->message('Not found');
 $rires->result(undef);
 $rires->extra({errno=>-100});


=head1 DESCRIPTION

L<Rinci> works using pure data structures, but sometimes it's convenient to have
an object-oriented interface for those data. This module provides just that.


=head1 FUNCTIONS

=head2 risub $meta => OBJECT

Exported by default. A shortcut for Perinci::Object::function->new($meta).

=head2 rivar $meta => OBJECT

Exported by default. A shortcut for Perinci::Object::variable->new($meta).

=head2 ripkg $meta => OBJECT

Exported by default. A shortcut for Perinci::Object::package->new($meta).

=head2 rires $res => OBJECT

Exported by default. A shortcut for Perinci::Object::Result->new($res).


=head1 SEE ALSO

L<Rinci>

=cut
