use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'Loggia'  }
BEGIN { use_ok 'Loggia::Controller::Album' }
BEGIN { use_ok 'Test::WWW::Mechanize::Catalyst' => 'Loggia' }

ok(request('/album/create')->is_success, 'Request should succeed');
ok(request('/album/list')->is_success,   'Request should succeed');

my $ua = Test::WWW::Mechanize::Catalyst->new();

$ua->get_ok('http://localhost/album/create');
$ua->title_is('Loggia - Create Album');

# check if page contains controls for name, description and submit
$ua->content_contains(q{name='name'});
$ua->content_contains(q{name='description'});
$ua->content_contains(q{name='submit'});

# post a name and description
my $name        = 'Paris';
my $description = 'Paris by night';

# create an album
$ua->submit_form(
    'fields' => {
        'name'        => $name,
        'description' => $description,
    }
);
$ua->content_contains(q{Album created successfully});

# duplicate albums should not be created
$ua->get_ok('http://localhost/album/create');
$ua->submit_form(
    'fields' => {
        'name'        => $name,
        'description' => $description,
    }
);
$ua->content_contains(q{Album creation failed});

# check if album exists
$ua->get_ok('http://localhost/album/list');
$ua->content_contains('Paris');
$ua->content_contains('Paris by night');

# delete album
$ua->submit_form('form_number' => 1);

# album should not exist as it has already been deleted
$ua->get_ok('http://localhost/album/list');
$ua->content_contains('No albums present');

done_testing();
