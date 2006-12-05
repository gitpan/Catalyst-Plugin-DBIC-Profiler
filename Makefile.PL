use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Catalyst::Plugin::DBIC::Profiler',
    AUTHOR              => 'Tomoyuki SAWA <travail@cabane.no-ip.org>',
    VERSION_FROM        => 'lib/Catalyst/Plugin/DBIC/Profiler.pm',
    ABSTRACT_FROM       => 'lib/Catalyst/Plugin/DBIC/Profiler.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Catalyst-Plugin-DBIC-Profiler-*' },
);
