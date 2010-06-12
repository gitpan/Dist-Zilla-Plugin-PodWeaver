
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'weave your Pod together from configuration and Dist::Zilla',
  'AUTHOR' => 'Ricardo SIGNES <rjbs@cpan.org>',
  'BUILD_REQUIRES' => {
    'File::Find::Rule' => '0',
    'Test::More' => '0'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'Dist-Zilla-Plugin-PodWeaver',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'Dist::Zilla::Plugin::PodWeaver',
  'PREREQ_PM' => {
    'List::MoreUtils' => '0',
    'Moose' => '0',
    'Moose::Autobox' => '0',
    'PPI' => '0',
    'Pod::Elemental' => '0',
    'Pod::Elemental::PerlMunger' => '0',
    'Pod::Elemental::Selectors' => '0',
    'Pod::Elemental::Transformer::Nester' => '0',
    'Pod::Elemental::Transformer::Pod5' => '0',
    'Pod::Weaver' => '3.100710',
    'Pod::Weaver::Config::Assembler' => '0',
    'namespace::autoclean' => '0'
  },
  'VERSION' => '3.101620',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



