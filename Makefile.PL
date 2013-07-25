
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "weave your Pod together from configuration and Dist::Zilla",
  "AUTHOR" => "Ricardo SIGNES <rjbs\@cpan.org>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Dist-Zilla-Plugin-PodWeaver",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Dist::Zilla::Plugin::PodWeaver",
  "PREREQ_PM" => {
    "Dist::Zilla" => "4",
    "Dist::Zilla::Role::FileFinderUser" => "0",
    "Dist::Zilla::Role::FileMunger" => "0",
    "List::MoreUtils" => "0",
    "Moose" => "0",
    "PPI" => "0",
    "Pod::Elemental::PerlMunger" => "0",
    "Pod::Weaver" => "3.100710",
    "Pod::Weaver::Config::Assembler" => "0",
    "namespace::autoclean" => "0"
  },
  "TEST_REQUIRES" => {
    "File::Find" => "0",
    "File::Find::Rule" => "0",
    "File::Temp" => "0",
    "Test::More" => "0.96",
    "strict" => "0",
    "warnings" => "0"
  },
  "VERSION" => "3.101642",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  my $tr = delete $WriteMakefileArgs{TEST_REQUIRES};
  my $br = $WriteMakefileArgs{BUILD_REQUIRES};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

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



