#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

BEGIN {
    use_ok('Catalyst::Test', 'Loggia');
    use_ok('Loggia::Controller::Image');
    use_ok('Test::WWW::Mechanize::Catalyst' => 'Loggia');
}

my $ua = Test::WWW::Mechanize::Catalyst->new();
$ua->get_ok('/image/retrieve/1');
$ua->content_contains('Near the University of Lisbon');

done_testing();
