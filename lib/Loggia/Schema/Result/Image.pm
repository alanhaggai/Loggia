package Loggia::Schema::Result::Image;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("image");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "description",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "hash",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 40,
  },
  "album",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-07-24 15:02:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:MtITuZkIRgOyGQMQHaPykQ

__PACKAGE__->belongs_to(
    'album' => 'Loggia::Schema::Result::Album',
    {'foreign.id' => 'self.album'},
);

# You can replace this text with custom content, and it will be preserved on regeneration
1;
