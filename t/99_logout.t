#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

BEGIN {
    use_ok('Catalyst::Test', 'Loggia');
    use_ok('Loggia::Controller::Admin');
    use_ok('Test::WWW::Mechanize::Catalyst' => 'Loggia');

    use lib 't';
    use_ok('Login');
}

my $ua = login();
$ua->get_ok('/admin/logout');

done_testing();
