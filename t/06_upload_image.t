#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

BEGIN {
    use_ok('Catalyst::Test', 'Loggia');
    use_ok('Loggia::Controller::Image');
    use_ok('Test::WWW::Mechanize::Catalyst' => 'Loggia');

    use lib 't';
    use_ok('Login');
}

my $ua = login();

# upload image
$ua->get_ok('/album/retrieve/1');
$ua->submit_form(
    'fields' => {
        'file'        => 't/files/images/near university of lisbon.jpg',
        'description' => 'Near the University of Lisbon',
        'album'       => '1',
    }
);

$ua->content_contains('Image uploaded successfully');

done_testing();
