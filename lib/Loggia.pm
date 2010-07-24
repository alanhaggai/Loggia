package Loggia;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    ConfigLoader
    Static::Simple
/;

extends 'Catalyst';

our $VERSION = '0.01';
$VERSION = eval $VERSION;

# Configure the application.
#
# Note that settings in loggia.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'Loggia',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
    'static' => {
        'dirs'  => ['static' => qr{^images/gallery/$}],
        'debug' => 1,
    },
);

# Start the application
__PACKAGE__->setup();


=head1 NAME

Loggia - Catalyst based application

=head1 SYNOPSIS

    script/loggia_server.pl

=head1 DESCRIPTION

The minimalist gallery!

=head1 SEE ALSO

L<Loggia::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Alan Haggai Alavi

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
