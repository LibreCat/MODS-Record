use strict;
use warnings;
use Module::Build;

my $build = Module::Build->new(
    module_name => 'MODS::Record',
    license => 'perl',
    dist_author => [
        'Patrick Hochstenbach <patrick.hochstenbach@ugent.be>',
    ],
    dist_version_from => 'lib/MODS/Record.pm',
    build_requires => {
        'Software::License' => 0,
        'Test::More' => '0.98',
    },
    requires => {
        'Moo' => 0,
        'JSON' => 0,
        'Carp' => 0,
        'XML::Parser' => 0,
        'IO::file' => 0,
    },
    create_makefile_pl => 'traditional',
    create_license => 1,
);

$build->create_build_script;
