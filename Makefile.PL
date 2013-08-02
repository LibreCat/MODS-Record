# vi:et:sw=4 ts=4
require v5.8.2;
use strict;
use ExtUtils::MakeMaker;

&WriteMakefile(
    NAME            => 'MODS::Record',
    DISTNAME        => 'MODS-Record',
    VERSION_FROM    => 'lib/MODS/Record.pm',
    ABSTRACT_FROM   => 'lib/MODS/Record.pm',
    PMLIBDIRS       => [ qw( lib/ ) ],
    AUTHOR          => 'Patrick <patrick.hochstenbach@ugent.be>',
    LICENSE         => 'perl',
    PREREQ_PM       => {
        'Test::More'  => 0,
        'Moo'         => 0,
        'JSON'        => 0,
        'Carp'        => 0,
        'XML::Parser' => 0,
    },
    dist            => {
        COMPRESS => 'gzip -9f',
        SUFFIX => 'gz',
    },
    depend          => {
        Makefile => '$(VERSION_FROM)'
    },
    clean           => { FILES => 'MODS-Record-*' },
    
);
