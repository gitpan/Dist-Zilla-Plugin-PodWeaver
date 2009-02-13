
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'Dist-Zilla-Plugin-PodWeaver',
  NAME      => 'Dist::Zilla::Plugin::PodWeaver',
  AUTHOR    => 'Ricardo\ SIGNES\ \<rjbs\@cpan\.org\>',
  ABSTRACT  => 'do horrible things to POD, producing better docs',
  VERSION   => '2.000',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.21) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "Dist::Zilla" => '1.004',
    "Pod::Weaver" => '1',
    "Moose::Autobox" => '0',
    "List::MoreUtils" => '0',
    "Moose" => '0',
  },
);
