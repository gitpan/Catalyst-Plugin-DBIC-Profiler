package # hide from PAUSE
    Catalyst::Plugin::DBIC::Profiler::DebugObj;

use warnings;
use strict;
use base qw/ DBIx::Class::Storage::Statistics /;
use Time::HiRes qw/ tv_interval gettimeofday /;

our $VERSION = '0.02';

sub new {
    my ( $pkg, %args ) = @_;

    bless \%args, $pkg;
}

sub txn_begin {
    my $self = shift;

    $self->{log}->debug("BEGIN WORK\n");
}

sub txn_rollback {
    my $self = shift;

    $self->{log}->debug("ROLLBACK\n");
}

sub txn_commit {
    my $self = shift;

    $self->{log}->debug("COMMIT\n");
}

sub query_start {
    my $self = shift;
    my $sql  = shift;
    my @args = @_;

    my $count = $self->{_count} ? $self->{_count} + 1 : 1;
    $self->{_count} = $count;

    my $bind_values = @args ? join ', ', @args : '';
    my $message = "SQL [$count]\n$sql\n";
    $message .= "Bind Values : ( $bind_values )\n";
    $self->{log}->debug( $message );
    $self->{start_time} = [ gettimeofday ];
}

sub query_end {
    my $self = shift;
    my $sql  = shift;
    my @args = @_;

    my $message = "-->Query Time : " . tv_interval( $self->{start_time}, [ gettimeofday ] ) . "\n";
    $self->{log}->debug( $message );
    $self->{start_time} = undef;
}

1; # End of Catalyst::Plugin::DBIC::Profiler::DebugObj
