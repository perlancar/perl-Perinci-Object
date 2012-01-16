#!perl

use 5.010;
use strict;
use warnings;
use Test::More 0.96;

use Rias::Object;

my $rires = rires [200, "OK", [1, 2, 3]];

is_deeply($rires->as_struct, [200, "OK", [1, 2, 3]], "as_struct 1");

is($rires->status, 200, "status");
is($rires->status(250), 200, "status (set) 1");
is($rires->status, 250, "status (set) 2");

ok($rires->is_success, "is_success 1");

is($rires->message, "OK", "message");
is($rires->message("Not found"), "OK", "message (set) 1");
is($rires->message, "Not found", "message (set) 2");

is($rires->status(404), 250, "status (set) 3");
ok(!$rires->is_success, "is_success 2");

is_deeply($rires->payload, [1,2,3], "payload");
is_deeply($rires->payload([4,5,6]), [1,2,3], "payload (set) 1");
is_deeply($rires->payload, [4,5,6], "payload (set) 2");

ok(!$rires->extra, "extra");
ok(!$rires->extra({errno=>-100}), "payload (set) 1");
is_deeply($rires->extra, {errno=>-100}, "payload (set) 2");

is_deeply($rires->as_struct,
          [404, "Not found", [4, 5, 6], {errno=>-100}], "as_struct 2");

done_testing();
