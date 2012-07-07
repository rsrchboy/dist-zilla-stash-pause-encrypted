package Dist::Zilla::Stash::PAUSE::Encrypted;

# ABSTRACT: Keep your PAUSE bits safely encrypted!

use Moose;
use namespace::autoclean;
use MooseX::AttributeShortcuts;
use Moose::Util::TypeConstraints 'class_type';

use Config::Identity::PAUSE;

extends 'Dist::Zilla::Stash::PAUSE';

#has _identity => ( is => 'lazy', isa => class_type('Config::Identity::PAUSE'),

has "+$_" => (traits => [Shortcuts], writer => "_set_$_", required => 0, init_arg => undef)
    for qw{ username password };

sub BUILD {
    my ($self) = @_;

    my %id = Config::Identity::PAUSE->load;
    $self->_set_username($id{user});
    $self->_set_password($id{password});

    return;
}

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
