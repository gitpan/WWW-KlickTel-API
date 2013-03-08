#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    ok(
        eval {
            # create cache directory
            my $username = $ENV{LOGNAME} || $ENV{USER} || getpwuid($<);
            my $cache_dir = '/var/cache/www-klicktel-api/';
            if ( $username ne 'root' ) {
                $cache_dir = '/home/' . $username . '/.klicktel/cache/';
                mkdir '/home/' . $username . '/.klicktel'
                    if !-d '/home/' . $username . '/.klicktel';
            }
            if ( !-d $cache_dir ) {
                mkdir $cache_dir
                    or die("cannot create cache dir '$cache_dir'.");
                chmod '0111', $cache_dir
                    or die("cannot chmod cache dir '$cache_dir'.");
            }
            return 1 if -w $cache_dir;
            return 0;
        },
        "creating and testing cache directory"
    );

}
