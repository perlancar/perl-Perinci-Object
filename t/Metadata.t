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

    description => "English d",
    "description.alt.lang.id" => "Bahasa d",
};

{
    local $ENV{LANG};
    local $ENV{LANGUAGE};
    is($rimeta->langprop("summary"), "English",
       "doesn't specify default_lang -> en_US");
}

{
    local $ENV{LANG} = "en_US.UTF-8";
    local $ENV{LANGUAGE};
    is($rimeta->langprop("summary"), "English",
       "value from LANG is trimmed");
}

{
    local $ENV{LANG};
    local $ENV{LANGUAGE} = "en_US.UTF-8";
    is($rimeta->langprop("summary"), "English",
       "value from LANG is trimmed");
}

is($rimeta->langprop({lang=>"id_ID"}, "summary"), "Bahasa",
   "specify lang id_ID");

is($rimeta->langprop({lang=>"id"}, "description"), "Bahasa d",
   "specify lang id");

{
    local $ENV{LANG};
    local $ENV{LANGUAGE} = "id_ID";
    is($rimeta->langprop("summary"), "Bahasa",
       "specify lang id_ID via env LANGUAGE");
}

{
    local $ENV{LANG} = "id_ID";
    local $ENV{LANGUAGE};
    is($rimeta->langprop("summary"), "Bahasa",
       "specify lang id_ID via env LANG");
}

is($rimeta->langprop({lang=>"fr_FR"}, "summary"), "{en_US English}",
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

is($rimeta->langprop({lang=>"id_ID"}, "description"), "Ba\nhasa\n",
   "specify lang=id_ID");
is($rimeta->langprop({lang=>"en_US"}, "description"), "Eng\nlish\n",
   "specify lang=en_US");
is($rimeta->langprop({lang=>"fr_FR"}, "description"), "{id_ID Ba\nhasa}\n",
   "specify non-existent lang fr_FR -> default_lang id_ID + marked");

is($rimeta->langprop({lang=>"fr_FR", mark_different_lang=>0}, "description"),
   "Ba\nhasa\n",
   "mark_different_lang=0");

done_testing;
