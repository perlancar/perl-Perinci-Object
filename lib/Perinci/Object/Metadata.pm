package Perinci::Object::Metadata;

use 5.010;
use strict;
use warnings;

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

sub _trim_blank_lines {
    my $self = shift;
    local $_ = shift;
    return $_ unless defined;
    s/\A(?:\n\s*)+//;
    s/(?:\n\s*){2,}\z/\n/;
    $_;
}

sub langprop {
    my ($self, $prop, $opts) = @_;
    $opts //= {};

    my $olang   = $opts->{lang} // "en_US";
    my $mlang   = ${$self}->{default_lang} // "en_US";
    my $fblang  = $opts->{fallback_lang} // "en_US";
    my $markfbt = $opts->{mark_fallback_text} // 1;

    #print "olang=$olang, mlang=$mlang, fblang=$fblang, markfbt=$markfbt\n";

    my $v;
    my $x; # x = exists
    if ($olang eq $mlang) {
        $x = exists ${$self}->{$prop};
        $v = ${$self}->{$prop};
    } else {
        my $k = "$prop.alt.lang.$olang";
        $x = exists ${$self}->{$k};
        $v = ${$self}->{$k};
    }
    $v = $self->_trim_blank_lines($v);
    return $v if $x;

    if ($fblang ne $olang) {
        if ($fblang eq $mlang) {
            $v = ${$self}->{$prop};
        } else {
            my $k = "$prop.alt.lang.$fblang";
            $v = ${$self}->{$k};
        }
        $v = $self->_trim_blank_lines($v);
        if (defined($v) && $markfbt) {
            my $has_nl = $v =~ s/\n\z//;
            $v = "{$fblang $v}" . ($has_nl ? "\n" : "");
        }
    }
    $v;
}

1;
# ABSTRACT: Base class for Perinci::Object metadata classes
