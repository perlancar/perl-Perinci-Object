package Perinci::Object;

use 5.010001;
use strict;
use warnings;

# VERSION

require Exporter;
our @ISA    = qw(Exporter);
our @EXPORT = qw(rimeta risub rivar ripkg envres riresmeta);

sub rimeta {
    require Perinci::Object::Metadata;
    Perinci::Object::Metadata->new(@_);
}

sub risub {
    require Perinci::Object::Function;
    Perinci::Object::Function->new(@_);
}

sub rivar {
    require Perinci::Object::Variable;
    Perinci::Object::Variable->new(@_);
}

sub ripkg {
    require Perinci::Object::Package;
    Perinci::Object::Package->new(@_);
}

sub envres {
    require Perinci::Object::EnvResult;
    Perinci::Object::EnvResult->new(@_);
}

sub riresmeta {
    require Perinci::Object::ResMeta;
    Perinci::Object::ResMeta->new(@_);
}

1;
# ABSTRACT: Object-oriented interface for Rinci metadata

=head1 SYNOPSIS

 use Perinci::Object; # automatically exports risub(), rivar(), ripkg(),
                      # envres(), riresmeta()
 use Data::Dump; # for dd()

 # OO interface to function metadata.

 my $risub = risub {
     v => 1.1,
     summary => 'Calculate foo and bar',
     "summary.alt.lang.id_ID" => 'Menghitung foo dan bar',
     args => { a1 => { schema => 'int*' }, a2 => { schema => 'str' } },
     features => { pure=>1 },
 };
 dd $risub->type,                         # "function"
    $risub->v,                            # 1.0
    $risub->arg('a1'),                    # { schema=>'int*' }
    $risub->arg('a3'),                    # undef
    $risub->feature('pure'),              # 1
    $risub->feature('foo'),               # undef
    $risub->langprop('summary'),          # 'Calculate foo and bar'
    $risub->langprop('summary', 'id_ID'), # 'Menghitung foo dan bar'

 # setting arg and property
 $risub->arg('a3', 'array');  # will actually fail for 1.0 metadata
 $risub->feature('foo', 2);   # ditto

 # OO interface to variable metadata

 my $rivar = rivar { ... };

 # OO interface to package metadata

 my $ripkg = ripkg { ... };

 # OO interface to enveloped result

 my $envres = envres [200, "OK", [1, 2, 3]];
 dd $envres->is_success, # 1
    $envres->status,     # 200
    $envres->message,    # "OK"
    $envres->result,     # [1, 2, 3]
    $envres->meta;       # undef

 # setting status, message, result, extra
 $envres->status(404);
 $envres->message('Not found');
 $envres->result(undef);
 $envres->meta({errno=>-100});

 # OO interface to function/method result metadata
 my $riresmeta = riresmeta { ... };


=head1 DESCRIPTION

L<Rinci> works using pure data structures, but sometimes it's convenient to have
an object-oriented interface (wrapper) for those data. This module provides just
that.


=head1 FUNCTIONS

=head2 rimeta $meta => OBJECT

Exported by default. A shortcut for Perinci::Object::Metadata->new($meta).

=head2 risub $meta => OBJECT

Exported by default. A shortcut for Perinci::Object::Function->new($meta).

=head2 rivar $meta => OBJECT

Exported by default. A shortcut for Perinci::Object::Variable->new($meta).

=head2 ripkg $meta => OBJECT

Exported by default. A shortcut for Perinci::Object::Package->new($meta).

=head2 envres $res => OBJECT

Exported by default. A shortcut for Perinci::Object::EnvResult->new($res).

=head2 riresmeta $resmeta => OBJECT

Exported by default. A shortcut for Perinci::Object::ResMeta->new($res).


=head1 SEE ALSO

L<Rinci>

=cut
