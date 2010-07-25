package Loggia::Schema::Result::UserToRole;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("user_to_role");
__PACKAGE__->add_columns(
  "user",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "role",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
);
__PACKAGE__->set_primary_key("user", "role");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-07-25 12:54:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:h4PuycjaCFGi+SiCrXh/XA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
