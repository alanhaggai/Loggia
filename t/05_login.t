use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'Loggia' }
BEGIN { use_ok 'Loggia::Controller::Admin' }
BEGIN { use_ok 'Test::WWW::Mechanize::Catalyst' => 'Loggia' }

my $ua = Test::WWW::Mechanize::Catalyst->new();
$ua->get_ok('/admin/login');
$ua->submit_form(
    'fields' => {
        'username' => 'loggia',
        'password' => '10gg14',
    }
);

done_testing();
