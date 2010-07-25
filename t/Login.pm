package Login;

use strict;
use warnings;
use Test::More;

use base 'Exporter';
our @EXPORT = qw(login);

# skip test if LOGGIA_USERNAME and LOGGIA_PASSWORD are not set
my ($username, $password);
BEGIN {
    $username = $ENV{'LOGGIA_USERNAME'};
    $password = $ENV{'LOGGIA_PASSWORD'};

    if (!$username or !$password) {
        plan skip_all =>
          'set LOGGIA_USERNAME and LOGGIA_PASSWORD to enable this test';
        done_testing();
    }
}

BEGIN { use_ok 'Catalyst::Test', 'Loggia' }
BEGIN { use_ok 'Loggia::Controller::Admin' }
BEGIN { use_ok 'Test::WWW::Mechanize::Catalyst' => 'Loggia' }

sub login {
    my $ua = Test::WWW::Mechanize::Catalyst->new();
    $ua->get_ok('/admin/login');
    ok($username, 'LOGGIA_USERNAME');
    ok($password, 'LOGGIA_PASSWORD');

    $ua->submit_form(
        'fields' => {
            'username' => $username,
            'password' => $password,
        }
    );

    # check if login succeeded
    $ua->get_ok('/admin/login');
    $ua->content_contains("You are already logged in as <strong>$username</strong>.");

    return $ua;
}

1;
