package Loggia::Controller::Image;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

use Digest::SHA1 'sha1_hex';
use File::Spec::Functions 'catfile';
use Image::Magick;

=head1 NAME

Loggia::Controller::Image - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 upload

Uploads image and renames it to SHA1SUM of the file. Redirect back to the album
to which the image has been uploaded.

=cut

sub upload :Local {
    my ( $self, $c ) = @_;

    $c->forward('/display_login');

    my %query_parametres;
    my $file        = $c->req->upload('file');
    my $description = $c->req->body_params->{'description'};
    my $album       = $c->req->body_params->{'album'};
    if ($file) {
        my $file_name          = $file->filename();
        my $fh                 = $file->fh();
        my $binary_data        = do { local $/; <$fh> };
        my $hash               = sha1_hex($binary_data);
        my $file_name_in_store = catfile('root/static/images/gallery', $hash);

        if ($file->copy_to($file_name_in_store)) {
            $query_parametres{'status'} = 'Image uploaded successfully';

            # resize image and generate thumbnail
            my $magick = Image::Magick->new();
            $magick->Read($file_name_in_store);

            $magick->Resize('geometry' => '800x600');
            $magick->Write($file_name_in_store);

            $magick->Thumbnail('geometry' => '150x150');
            $magick->Write(
                catfile('root/static/images/gallery/thumbnails', $hash),
            );

            my $image = $c->model('DB::Image');
            $image->create({
                'description' => $description,
                'hash'        => $hash,
                'album'       => $album,
            });
        }
        else {
            $query_parametres{'error'} = 'Image upload failed';
        }
    }
    else {
            $query_parametres{'error'} = 'No image was selected for upload';
    }

    if ($album) {
        $c->res->redirect(
            $c->uri_for("/album/retrieve/$album", \%query_parametres)
        );
    }
    else {
        $c->res->redirect(
            $c->uri_for('/album/list', \%query_parametres)
        );
    }
}

=head2 retrieve

Retrieve image from gallery.

=cut

sub retrieve :Local :Args(1) {
    my ($self, $c, $id) = @_;

    my $image  = $c->model('DB::Image')->find($id);
    if ($image) {
        my $file_name = catfile('/static/images/gallery', $image->hash());

        $c->stash(
            'image'    => $image,
            'template' => 'image/retrieve.tt',
        );
    }
    else {
        $c->stash('error' => 'Image not found');
    }
}

=head2 delete

Delete image from album.

=cut

sub delete :Local {
    my ($self, $c) = @_;

    $c->forward('/display_login');

    my $image_id = $c->req->body_params->{'image'};
    my $album_id = $c->req->body_params->{'album'};

    my $image = $c->model('DB::Image')->find($image_id);
    my %query_parametres;
    if ($image->delete()) {
        $query_parametres{'status'} = 'Image deleted successfully';
    }
    else {
        $query_parametres{'error'} = 'Image deletion failed';
    }

    $c->res->redirect(
        $c->uri_for("/album/retrieve/$album_id", \%query_parametres)
    );
}

=head1 AUTHOR

Alan Haggai Alavi

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
