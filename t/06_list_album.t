#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

BEGIN {
    use_ok('Catalyst::Test', 'Loggia');
    use_ok('Loggia::Controller::Album');
    use_ok('Test::WWW::Mechanize::Catalyst' => 'Loggia');
}

my $ua = Test::WWW::Mechanize::Catalyst->new();
$ua->get_ok('/album/list');

$ua->content_contains('Portugal');
$ua->content_contains('YAPC::EU::2009');

done_testing();
