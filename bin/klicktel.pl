#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

=head1 NAME

klicktel.pl - A program for demonstrating the KlickTel API perl module

=head1 VERSION

Version: $Revision: 7 $

=cut

my ($VERSION) = ( q$Revision: 7 $ =~ /(\d+)/ );

=head1 SYNOPSIS

    klicktel.pl {[-h] | [-v]}
    klicktel.pl [invers <phone number>]

    Command  | Description
    -----------------------------------------------
    invers   | reverse lookup <phone number>


=head1 SETTINGS

 my $API_KEY = '';

=cut

my $API_KEY = '';

=head1 DEPENDENCIES

    WWW::KlickTel::API

=cut

use Data::Dumper;

# load local module(s)
use WWW::KlickTel::API;

# process options and parameter $ARGV[0]
my $method   = $ARGV[0];
my $option_0 = q{};
$option_0 = $ARGV[1] if $ARGV[1];

# no option or command
if ( !defined $method ) {
    say 'Usage: klicktel.pl {[-h] | [-v] | [option <value>]}';
    say '       use "klicktel.pl -h" for help.';
}

# help request
elsif ( $method eq '-h' ) {
    use Pod::Usage;
    pod2usage(1);
}

# version request
elsif ( $method eq '-v' ) {
    say "Version $VERSION";
}

# test for existing method
elsif ( exists &{ 'WWW::KlickTel::API::' . $method } ) {

    # create object
    my $klicktel = WWW::KlickTel::API->new(
        api_key => $API_KEY,    # required
           # protocol    => 'http' or 'https',                      # optional
           # cache_path  => '/var/cache/www-klicktel-api/',         # optional
           # uri_invers  => 'openapi.klicktel.de/searchapi/invers', # optional
    );

    if ( $method eq 'test' ) {

        # run selftest
        my $error_count;
        $error_count = $klicktel->test();
        say 'Module test: '
            . ( $error_count ? "FAILED. $error_count error(s)" : 'OK' );
    }
    elsif ( $method eq 'invers' ) {

        # invers - reverse lookup numbers
        if ( $option_0 !~ /^[0-9]+\z/ ) {
            say "Usage: $0 invers <phone number>";
            if ($option_0) {
                say "   '$option_0' is not a valid phone number.\n"
                    . "   Example: $0 invers 0401234567";
            }
            exit;
        }

        # print the hash dump
        say Dumper( $klicktel->invers($option_0) );
    }
}
else {
    # we didn't get a valid method or a command
    say 'None such method "' . $method . '".\nTry "' . $0 . ' -h".';
}

1;
