package Catalyst::Plugin::DBIC::Profiler;

use strict;
use warnings;
use NEXT;
use Catalyst::Plugin::DBIC::Profiler::DebugObj;

=head1 NAME

Catalyst::Plugin::DBIC::Proflier - Profile time query took with DBIC or DBIC::Schema in your application.

=head1 VERSION

Version 0.02

=cut

our $VERSION = '0.02';

=head1 SYNOPSIS

  # In your application class MyApp.pm
  # Load Catalyst::Plugin::DBIC::Profiler. Done.
  use Catalyst qw/
      Foo::Plugin
      Bar::Plugin
      Kore::Plugin
      Sore::Plugin
      ...
      DBIC::Profiler    # Load this plugin.
      ...
  /;

=head1 DESCRIPTION

As indicated above load this plugin, then run your application.This plugin output your SQL statment, time your query took and number of times your query executed just like below.

  [debug] SQL[23]
  SELECT me.id, me.create_on, me.modify_on, me.modify_by, me.password, me.master_group_id, me.email, me.login_on FROM master_user me WHERE ( email = ? )
  Bind Values : ( 'precure@example.com' )
  [debug] -->Query Time : 0.003177

  # In case of running txn_begin.
  [debug] BEGIN WORK

  # In case of running txn_rollback.
  [debug] RALLBACK

  # In case of running txn_commit
  [debug] COMMIT

  # When you use transaction(txn_begin, txn_rollback, txn_commit), set MODEL_NAME in you configuration.
  # If you have MyApp::Model::DBIC::MyApp
  DBIC::Profiler:
    MODEL_NAME: DBIC::MyApp

=cut

sub prepare {
    my $c = shift;

    $c = $c->NEXT::prepare(@_);

    my $model_name = $c->config->{'DBIC::Profiler'}->{MODEL_NAME};
    unless ( $model_name ) {
        $c->log->warn( __PACKAGE__ . ": No MODEL_NAME specified" );
        return $c unless $model_name;
    }

    $c->model( $model_name )->storage->debug( 1 );
    $c->model( $model_name )->storage->debugobj( Catalyst::Plugin::DBIC::Profiler::DebugObj->new( log => $c->log ) );
    return $c;
}

=head1 AUTHOR

Tomoyuki SAWA, C<< <travail at cabane.no-ip.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-catalyst-plugin-dbic-profiler at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Catalyst-Plugin-DBIC-Profiler>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Catalyst::Plugin::DBIC::Profiler

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Catalyst-Plugin-DBIC-Profiler>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Catalyst-Plugin-DBIC-Profiler>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Catalyst-Plugin-DBIC-Profiler>

=item * Search CPAN

L<http://search.cpan.org/dist/Catalyst-Plugin-DBIC-Profiler>

=back

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright (C) 2006 by Tomoyuki SAWA

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.2 or,
at your option, any later version of Perl 5 you may have available.

=cut

1; # End of Catalyst::Plugin::DBIC::Profiler
