package # hide from PAUSE
    Catalyst::Plugin::DBIC::Profiler::DebugObj;

use warnings;
use strict;
use base 'DBIx::Class::Storage::Statistics';
use Time::HiRes qw/ tv_interval gettimeofday /;

our $VERSION = '0.01';

sub new {
    my ( $pkg, %args ) = @_;

    bless \%args, $pkg;
}

sub txn_begin {
    my $self = shift;

    $self->{log}->debug( "BEGIN WORK\n" );
}

sub txn_rollback {
    my $self = shift;

    $self->{log}->debug( "ROLLBACK\n" );
}

sub txn_commit {
    my $self = shift;

    $self->{log}->debug( "COMMIT\n" );
}

sub query_start {
    my $self = shift;
    my $sql  = shift;
    my @args = @_;

    my $bind = @args ? join ', ', @args : '';
#    $sql =~ s/FROM/\nFROM/g;
#    $sql =~ s/,/,\n    /g;
#    $sql =~ s/JOIN/\nJOIN/g;
#    $sql =~ s/WHERE/\nWHERE/g;
#    my $message = "Executing \n $sql : $bind\n";
    my $message = "Executing \n$sql\n";
    $message .= "Bind Values : ( $bind )\n";
    $self->{log}->debug( $message );
    $self->{start_time} = [gettimeofday];
}

sub query_end {
    my $self = shift;
    my $sql  = shift;
    my @args = @_;

    my $message = "-->Query Time : ".tv_interval( $self->{start_time} )."\n";
    $self->{log}->debug( $message );
    $self->{start_time} = undef;
}

1; # End of Catalyst::Plugin::DBIC::Profiler::DebugObj
