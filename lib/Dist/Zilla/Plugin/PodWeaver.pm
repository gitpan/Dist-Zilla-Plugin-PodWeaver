package Dist::Zilla::Plugin::PodWeaver;
{
  $Dist::Zilla::Plugin::PodWeaver::VERSION = '3.102000';
}
# ABSTRACT: weave your Pod together from configuration and Dist::Zilla
use Moose;
use List::MoreUtils qw(any);
use Pod::Weaver 3.100710; # logging with proxies
with(
  'Dist::Zilla::Role::FileMunger',
  'Dist::Zilla::Role::FileFinderUser' => {
    default_finders => [ ':InstallModules', ':ExecFiles' ],
  },
);

use namespace::autoclean;


sub weaver {
  my ($self) = @_;

  my @files = glob($self->zilla->root->file('weaver.*'));

  my $arg = {
      root        => $self->zilla->root,
      root_config => { logger => $self->logger },
  };

  if ($self->config_plugin) {
    my $assembler = Pod::Weaver::Config::Assembler->new;

    my $root = $assembler->section_class->new({ name => '_' });
    $assembler->sequence->add_section($root);

    $assembler->change_section( $self->config_plugin );
    $assembler->end_section;

    return Pod::Weaver->new_from_config_sequence($assembler->sequence, $arg);
  } elsif (@files) {
    return Pod::Weaver->new_from_config(
      { root   => $self->zilla->root },
      { logger => $self->logger },
    );
  } else {
    return Pod::Weaver->new_with_default_config($arg);
  }
}

has config_plugin => (
  is  => 'ro',
  isa => 'Str',
);

around dump_config => sub
{
  my ($orig, $self) = @_;
  my $config = $self->$orig;

  $config->{'' . __PACKAGE__} = {
     $self->config_plugin ? ( config_plugin => $self->config_plugin ) : (),
     finder => $self->finder,
  };
  return $config;
};

sub munge_files {
  my ($self) = @_;

  require PPI;
  require Pod::Weaver;
  require Pod::Weaver::Config::Assembler;

  $self->munge_file($_) for @{ $self->found_files };
}

sub munge_file {
  my ($self, $file) = @_;

  $self->log_debug([ 'weaving pod in %s', $file->name ]);

  $self->munge_pod($file);
  return;
}

sub munge_perl_string {
  my ($self, $doc, $arg) = @_;

  my $weaver  = $self->weaver;
  my $new_doc = $weaver->weave_document({
    %$arg,
    pod_document => $doc->{pod},
    ppi_document => $doc->{ppi},
  });

  return {
    pod => $new_doc,
    ppi => $doc->{ppi},
  }
}

sub munge_pod {
  my ($self, $file) = @_;

  my $content     = $file->content;
  my $new_content = $self->munge_perl_string(
    $file->content,
    {
      zilla    => $self->zilla,
      filename => $file->name,
      version  => $self->zilla->version,
      license  => $self->zilla->license,
      authors  => $self->zilla->authors,
      distmeta => $self->zilla->distmeta,
    },
  );

  $file->content($new_content);

  return;
}

with 'Pod::Elemental::PerlMunger';

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::Plugin::PodWeaver - weave your Pod together from configuration and Dist::Zilla

=head1 VERSION

version 3.102000

=head1 DESCRIPTION

[PodWeaver] is the bridge between L<Dist::Zilla> and L<Pod::Weaver>.  It rips
apart your kinda-Pod and reconstructs it as boring old real Pod.

=head1 ATTRIBUTES

=head2 finder

[PodWeaver] is a L<Dist::Zilla::Role::FileFinderUser>.  The L<FileFinder> given
for its C<finder> attribute is used to decide which files to munge.  By
default, it will munge:

=over 4

=item *

C<:InstallModules>

=item *

C<:ExecFiles>

=back

=head1 METHODS

=head2 weaver

This method returns the Pod::Weaver object to be used.  The current
implementation builds a new weaver on each invocation, because one or two core
Pod::Weaver plugins cannot be trusted to handle multiple documents per plugin
instance.  In the future, when that is fixed, this may become an accessor of an
attribute with a builder.  Until this is clearer, use caution when modifying
this method in subclasses.

=head1 CONFIGURATION

If the C<config_plugin> attribute is given, it will be treated like a
Pod::Weaver section heading.  For example, C<@Default> could be given.

Otherwise, if a file matching C<./weaver.*> exists, Pod::Weaver will be told to
look for configuration in the current directory.

Otherwise, it will use the default configuration.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
