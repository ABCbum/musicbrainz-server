package MusicBrainz::Server::Form::Annotation;
use HTML::FormHandler::Moose;
extends 'MusicBrainz::Server::Form';
with 'MusicBrainz::Server::Form::Role::Edit';

has '+name' => (default => 'edit-annotation');

has_field 'text' => (
    type     => 'Text',
);

# has 'annotation_model' => (
#     is       => 'ro',
#     required => 1
# );

# has 'entity_id' => (
#     is       => 'ro',
#     required => 1
# );

has_field 'revision_id' => (
    type => 'Integer',
    value => 'required'
);

has_field 'preview' => (
    type => 'Submit',
    value => ''
);

sub edit_field_names { qw( text changelog ) }

# sub validate
# {
#     my ($self) = @_;

#     # The "text" field is required only if the previous annotation was blank
#     my $previous_annotanion = $self->annotation_model->get_latest($self->entity_id);
#     $self->field('text')->required($previous_annotanion && $previous_annotanion->text ? 0 : 1);
#     $self->field('text')->validate_field;
# }

__PACKAGE__->meta->make_immutable;
no Moose;
1;
