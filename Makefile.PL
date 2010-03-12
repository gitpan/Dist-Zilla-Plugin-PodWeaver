
use strict;
use warnings;



use ExtUtils::MakeMaker 6.11;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t'
                                 },
                       'NAME' => 'Dist::Zilla::Plugin::PodWeaver',
                       'DISTNAME' => 'Dist-Zilla-Plugin-PodWeaver',
                       'CONFIGURE_REQUIRES' => {
                                                 'ExtUtils::MakeMaker' => '6.11'
                                               },
                       'AUTHOR' => 'Ricardo SIGNES <rjbs@cpan.org>',
                       'BUILD_REQUIRES' => {},
                       'ABSTRACT' => 'weave your Pod together from configuration and Dist::Zilla',
                       'EXE_FILES' => [],
                       'VERSION' => '3.100710',
                       'PREREQ_PM' => {
                                        'PPI' => '0',
                                        'File::Find::Rule' => '0',
                                        'Pod::Elemental' => '0',
                                        'namespace::autoclean' => '0',
                                        'Pod::Elemental::PerlMunger' => '0',
                                        'Moose::Autobox' => '0',
                                        'Pod::Weaver::Config::Assembler' => '0',
                                        'Test::More' => '0',
                                        'Dist::Zilla::Role::FileMunger' => '1.100710',
                                        'Pod::Elemental::Transformer::Pod5' => '0',
                                        'Pod::Weaver' => '3.100710',
                                        'Pod::Elemental::Transformer::Nester' => '0',
                                        'Pod::Elemental::Selectors' => '0',
                                        'List::MoreUtils' => '0',
                                        'Moose' => '0'
                                      },
                       'LICENSE' => 'perl'
                     );


delete $WriteMakefileArgs{LICENSE}
  unless eval { ExtUtils::MakeMaker->VERSION(6.31) };

WriteMakefile(%WriteMakefileArgs);



