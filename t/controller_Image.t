use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'Loggia' }
BEGIN { use_ok 'Loggia::Controller::Image' }
BEGIN { use_ok 'Test::WWW::Mechanize::Catalyst' => 'Loggia' }

# image upload without an image
my $response = request('/image/upload');
ok($response->is_redirect(), 'Redirect');
is(
    $response->header('location'),
    'http://localhost/album/retrieve/?error=No+image+was+selected+for+upload',
    'No image was selected for upload'
);

# upload image
my $ua = Test::WWW::Mechanize::Catalyst->new();
$ua->get_ok('/album/retrieve/1');
$ua->submit_form(
    'fields' => {
        'file'        => 't/files/images/near university of lisbon.jpg',
        'description' => 'Near the University of Lisbon',
        'album'       => '1',
    }
);


# check if image exists
$ua->get_ok('/image/retrieve/1');
$ua->content_lacks('Image not found');

done_testing();
