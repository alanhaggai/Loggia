package Loggia::Controller::Album;
use Moose;
use namespace::autoclean;
use Try::Tiny;

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

    try {
        my $album = $c->model('DB::Album')->create({
            'name'        => $name,
            'description' => $description,
        });
    }
    catch {
        $c->res->status(500);
        $c->stash('error' => 'Album creation failed');
    };

    $c->stash('template' => 'album/create-do.tt');
}

=head2 list

List existing albums.

=cut

sub list :Local {
    my ($self, $c) = @_;

    try {
        my @albums = $c->model('DB::Album')->search();
        $c->stash('albums' => \@albums);
    }
    catch {
        $c->res->status(500);
        $c->stash('error' => 'Album listing failed');
    };

    $c->stash('template' => 'album/list.tt');
}

=head1 AUTHOR

Alan Haggai Alavi

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

