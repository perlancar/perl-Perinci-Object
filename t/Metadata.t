#!perl

use 5.010;
use strict;
use warnings;
use Test::More 0.96;
use Test::Exception;

use Perinci::Object;

my $rimeta = rimeta {
    v => 1.1,
    summary => "English",
    "summary.alt.lang.id_ID" => "Bahasa",
};

{
    local $ENV{LANG};
    local $ENV{LANGUAGE};
    is($rimeta->langprop("summary"), "English",
       "doesn't specify default_lang -> en_US");
}

is($rimeta->langprop("summary", {lang=>"id_ID"}), "Bahasa",
   "specify lang id_ID");

{
    local $ENV{LANG};
    local $ENV{LANGUAGE} = "id_ID";
    is($rimeta->langprop("summary", {}), "Bahasa",
       "specify lang id_ID via env LANGUAGE");
}

{
    local $ENV{LANG} = "id_ID";
    local $ENV{LANGUAGE};
    is($rimeta->langprop("summary", {}), "Bahasa",
       "specify lang id_ID via env LANG");
}

is($rimeta->langprop("summary", {lang=>"fr_FR"}), "{en_US English}",
   "specify non-existent lang fr_FR -> default_lang + marked");

$rimeta = rimeta {
    v => 1.1,
    default_lang => "id_ID",
    description => "Ba\nhasa\n",
    "description.alt.lang.en_US" => "Eng\nlish\n",
};

{
    local $ENV{LANG};
    local $ENV{LANGUAGE};
    is($rimeta->langprop("description"), "Ba\nhasa\n",
       "default_lang id_ID");
}

is($rimeta->langprop("description", {lang=>"id_ID"}), "Ba\nhasa\n",
   "specify lang=id_ID");
is($rimeta->langprop("description", {lang=>"en_US"}), "Eng\nlish\n",
   "specify lang=en_US");
is($rimeta->langprop("description", {lang=>"fr_FR"}), "{id_ID Ba\nhasa}\n",
   "specify non-existent lang fr_FR -> default_lang id_ID + marked");

is($rimeta->langprop("description", {lang=>"fr_FR", mark_different_lang=>0}),
   "Ba\nhasa\n",
   "mark_different_lang=0");

done_testing();
