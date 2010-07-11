package Loggia::Schema::Result::Album;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("album");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 100,
  },
  "description",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("name", ["name"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-07-08 07:22:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cFbTpdYsbqR8X1lbUSJaWA

__PACKAGE__->has_many(
    'images' => 'Loggia::Schema::Result::Image',
    {'foreign.album' => 'self.id'},
);

# You can replace this text with custom content, and it will be preserved on regeneration
1;
