package Loggia::Schema::Result::Role;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("role");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "role",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 20,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("role", ["role"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-07-25 12:54:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:4Ax3Wq6ynKX2eNTcP62dRw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
