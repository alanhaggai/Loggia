package Loggia::Controller::Admin;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Loggia::Controller::Admin - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=head2 login

Display login template which asks for username and password.

=cut

sub login :Local {
    my ($self, $c) = @_;

    $c->stash('template' => 'admin/login.tt');
}

=head2 login_do

Log user in after successful authentication and redirect to root.

=cut

sub login_do :Path('login.do') {
    my ($self, $c) = @_;

    my $username = $c->req->body_params->{'username'};
    my $password = $c->req->body_params->{'password'};

    my $authenticated = $c->authenticate({
        'username' => $username,
        'password' => $password,
    });

    my %query_parametres;
    if ($authenticated) {
        $query_parametres{'status'} = 'Logged in successfully';
    }
    else {
        $query_parametres{'error'} = 'Incorrect credentials provided';
    }

    $c->res->redirect(
        $c->uri_for('/', \%query_parametres)
    );
}

=head2 logout

Log user out.

=cut

sub logout :Local {
    my ($self, $c) = @_;

    $c->logout();
    $c->res->redirect('/');
}

=head1 AUTHOR

Alan Haggai Alavi

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
