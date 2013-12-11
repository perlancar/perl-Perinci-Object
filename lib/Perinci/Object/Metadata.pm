package Perinci::Object::Metadata;

use 5.010;
use strict;
use warnings;
use SHARYANTO::String::Util qw(trim_blank_lines);

# VERSION

sub new {
    my ($class, $meta) = @_;
    $meta //= {};
    my $obj = \$meta;
    bless $obj, $class;
}

sub v {
    my $self = shift;
    ${$self}->{v} // 1.0;
}

sub type {
    die "BUG: type() must be subclassed";
}

sub as_struct {
    my $self = shift;
    ${$self};
}

sub langprop {
    my ($self, $prop, $opts) = @_;
    $opts //= {};

    my $deflang = ${$self}->{default_lang} // "en_US";
    my $olang   = $opts->{lang} || $ENV{LANGUAGE} || $ENV{LANG} || $deflang;
    my $mark    = $opts->{mark_different_lang} // 1;
    #print "deflang=$deflang, olang=$olang, mark_different_lang=$mark\n";

    my @k;
    if ($olang eq $deflang) {
        @k = ([$olang, $prop, 0]);
    } else {
        @k = ([$olang, "$prop.alt.lang.$olang", 0], [$deflang, $prop, $mark]);
    }

    for my $k (@k) {
        #print "k=".join(", ", @$k)."\n";
        my $v = ${$self}->{$k->[1]};
        if (defined $v) {
            if ($k->[2]) {
                my $has_nl = $v =~ s/\n\z//;
                $v = "{$k->[0] $v}" . ($has_nl ? "\n" : "");
            }
            return trim_blank_lines($v);
        }
    }
    return undef;
}

1;
# ABSTRACT: Base class for Perinci::Object metadata classes

=head1 METHODS

=head2 v

=head2 as_struct

=head2 langprop($prop, \%opts)

Get property value in the specified language (i.e., either in C<prop> or
C<prop.alt.lang.XXX> properties).

Known options:

=over 4

=item * lang => STR

Defaults to metadata's C<default_lang> (which in turns default to C<en_US> if
unspecified).

=item * mark_different_lang => BOOL (defaults to 1)

If set to true, text with different language than the language requested will be
marked, e.g. C<"I love you"> requested in Indonesian language where the value
for that language is unavailable will result in C<"{en_US I love you}"> being
returned.

=back

=cut
