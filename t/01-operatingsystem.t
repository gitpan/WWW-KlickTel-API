#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    ok( eval { $^O eq "linux"; } ) || BAIL_OUT("OS unsupported");;
}