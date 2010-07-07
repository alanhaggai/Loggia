use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'Loggia'  }
BEGIN { use_ok 'Loggia::Controller::Album' }

ok(request('/album/create')->is_success,    'Request should succeed');
ok(request('/album/create.do')->is_success, 'Request should succeed');
done_testing();
