use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'Loggia'  }
BEGIN { use_ok 'Loggia::Controller::Album' }
BEGIN { use_ok 'Test::WWW::Mechanize::Catalyst' => 'Loggia' }

my $ua = Test::WWW::Mechanize::Catalyst->new();

# check if album exists
$ua->get_ok('http://localhost/album/list');
$ua->content_contains('Portugal');
$ua->content_contains('YAPC::EU::2009');

# delete album
$ua->submit_form('form_number' => 1);

# album should not exist as it has already been deleted
$ua->get_ok('http://localhost/album/list');
$ua->content_contains('No albums present');

done_testing();
