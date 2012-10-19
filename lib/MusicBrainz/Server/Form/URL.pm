package MusicBrainz::Server::Form::URL;
use HTML::FormHandler::Moose;

extends 'MusicBrainz::Server::Form';
with 'MusicBrainz::Server::Form::Role::Edit';

has '+name' => ( default => 'edit-url' );

has_field 'url' => (
    type      => '+MusicBrainz::Server::Form::Field::URL',
    required  => 1,
);

sub edit_field_names { qw( url ) }

__PACKAGE__->meta->make_immutable;
1;
