package Dist::Zilla::Stash::PAUSE::Encrypted;

# ABSTRACT: Keep your PAUSE bits safely encrypted!

use Moose;
use namespace::autoclean;
use MooseX::AttributeShortcuts;

use Config::Identity::PAUSE;

extends 'Dist::Zilla::Stash::PAUSE';

has "+$_" => (traits => [Shortcuts], lazy => 1, builder => 1, required => 0)
    for qw{ username password };

has identity => (
    traits  => ['Hash'],
    is      => 'lazy',
    isa     => 'HashRef',
    handles => {
        _build_username => [ get => 'username' ],
        _build_password => [ get => 'password' ],
    },
);

sub _build_identity { my %id = Config::Identity::PAUSE->load; \%id }

__PACKAGE__->meta->make_immutable;
!!42;
__END__

=for Pod::Coverage BUILD

=for :stopwords magicky

=head1 SYNOPSIS

    # ...do the GPG magicky things described by Config::Identity, then:

    # in your ~/.dzil/config.ini
    [%PAUSE::Encrypted / %PAUSE]

=head1 DESCRIPTION

This is a simple extension of L<Dist::Zilla::Stash::PAUSE> to use
L<Config::Identity> to store and access an encrypted version of your PAUSE
user id and password.

=head1 SEE ALSO

L<Config::Identity>

L<Dist::Zilla::Stash::PAUSE>

L<Dist::Zilla::Plugin::UploadToCPAN>

=cut
