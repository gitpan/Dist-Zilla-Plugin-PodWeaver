
use strict;
use warnings;



use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'Dist-Zilla-Plugin-PodWeaver',
  NAME      => 'Dist::Zilla::Plugin::PodWeaver',
  AUTHOR    => "Ricardo\ SIGNES\ \<rjbs\@cpan\.org\>",
  ABSTRACT  => "weave\ your\ Pod\ together\ from\ configuration\ and\ Dist\:\:Zilla",
  VERSION   => '3.093321',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.31) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "Dist::Zilla" => '1.004',
    "Pod::Weaver" => '3.093001',
    "Moose::Autobox" => '0',
    "Pod::Elemental::PerlMunger" => '0',
    "List::MoreUtils" => '0',
    "Moose" => '0',
  },
  test => {TESTS => 't/*.t'}
);

