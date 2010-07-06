package Loggia::View::TT;

use strict;
use warnings;

use base 'Catalyst::View::TT';
use Loggia;

__PACKAGE__->config(
    'INCLUDE_PATH'       => Loggia->path_to('root', 'tt'),
    'WRAPPER'            => 'wrapper.tt',
    'TEMPLATE_EXTENSION' => '.tt',
);

=head1 NAME

Loggia::View::TT - TT View for Loggia

=head1 DESCRIPTION

TT View for Loggia.

=head1 SEE ALSO

L<Loggia>

=head1 AUTHOR

Alan Haggai Alavi

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
