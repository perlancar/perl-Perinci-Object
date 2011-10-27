#!perl

use 5.010;
use strict;
use warnings;
use Test::More 0.96;

use Sub::Spec::Object;

my $ssspec = ssspec { };

ok(!$ssspec->feature('foo'), "feature");
ok(!$ssspec->arg('j'), "arg");

$ssspec->feature('foo', 2);
is($ssspec->feature('foo'), 2, "feature, set");

$ssspec->arg('j', 'str');
is($ssspec->arg('j'), 'str', "arg, set");

$ssspec = ssspec { features => {undo=>1}, args => {i=>'int'} };

is($ssspec->feature('undo'), 1, "feature (2)");
is($ssspec->arg('i'), 'int', "arg (2)");

done_testing();
