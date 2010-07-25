package Loggia::Schema::Result::User;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("user");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "username",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 50,
  },
  "password",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 50,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("username", ["username"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-07-25 12:54:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:rqhHoJaK0IkPzsy3z8VnhQ

__PACKAGE__->has_many(
    'user_to_role' => 'Loggia::Schema::Result::UserToRole',
    {'foreign.user' => 'self.id'},
);

__PACKAGE__->many_to_many(
    'roles' => 'user_to_role',
    'role',
);

# You can replace this text with custom content, and it will be preserved on regeneration
1;
