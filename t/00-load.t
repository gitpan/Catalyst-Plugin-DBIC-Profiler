#!perl -T

use Test::More tests => 4;

BEGIN {
	use_ok( 'Catalyst' );
	use_ok( 'Catalyst::Model::DBIC' );
	use_ok( 'Catalyst::Plugin::DBIC::Profiler' );
	use_ok( 'Catalyst::Plugin::DBIC::Profiler::DebugObj' );
}

diag( "Testing Catalyst::Plugin::DBIC::Profiler $Catalyst::Plugin::DBIC::Profiler::VERSION, Perl $], $^X" );
