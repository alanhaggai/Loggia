package Loggia::Controller::Album;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Loggia::Controller::Album - Catalyst Controller

=head1 DESCRIPTION

Controller for album CRUD.

=head1 METHODS

=head2 create

Render template for creating album.

=cut

sub create :Local {
    my ($self, $c) = @_;

    $c->stash('template' => 'album/create.tt');
}

=head2 create_do

Do the actual album creation.

=cut

sub create_do :Path('create.do') {
    my ($self, $c) = @_;

    my $name        = $c->req->body_params->{'name'};
    my $description = $c->req->body_params->{'description'};

    # TODO:
    #   Check if an album with the same name exists or not.
    #   If not, create an album with the name and description.

    $c->stash('template' => 'album/create-do.tt');
}

=head1 AUTHOR

Alan Haggai Alavi

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

