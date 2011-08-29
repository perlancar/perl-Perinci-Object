#!perl

use 5.010;
use strict;
use warnings;
use Test::More 0.96;

use Sub::Spec::Object;

my $ssres = ssres [200, "OK", [1, 2, 3]];

is($ssres->status, 200, "status");
is($ssres->status(250), 200, "status (set) 1");
is($ssres->status, 250, "status (set) 2");

ok($ssres->is_success, "is_success");

is($ssres->message, "OK", "message");
is($ssres->message("Baik"), "OK", "message (set) 1");
is($ssres->message, "Baik", "message (set) 2");

is_deeply($ssres->result, [1,2,3], "result");
is_deeply($ssres->result([4,5,6]), [1,2,3], "result (set) 1");
is_deeply($ssres->result, [4,5,6], "result (set) 2");

done_testing();
