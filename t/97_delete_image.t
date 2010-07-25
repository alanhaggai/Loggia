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

# check if image exists
$ua->get_ok('/album/retrieve/1');
$ua->content_contains('Near the University of Lisbon');

# delete image
$ua->submit_form('form_number' => 2);

# image should not exist as it has already been deleted
$ua->get_ok('/image/retrieve/1');
$ua->content_contains('Image not found');

done_testing();
