use utf8;

package Interchange6::Schema::Result::UserAttribute;

=head1 NAME

Interchange6::Schema::Result::UserAttribute

=cut

use Interchange6::Schema::Candy;

=head1 ACCESSORS

=head2 user_attributes_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'user_attributes_user_attributes_id_seq'
  primary key

=cut

primary_column user_attributes_id => {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "user_attributes_user_attributes_id_seq",
};

=head2 users_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

column users_id =>
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 };

=head2 attributes_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

column attributes_id =>
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 };

=head1 RELATIONS

=head2 user

Type: belongs_to

Related object: L<Interchange6::Schema::Result::User>

=cut

belongs_to
  user => "Interchange6::Schema::Result::User",
  "users_id",
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" };

=head2 attribute

Type: belongs_to

Related object: L<Interchange6::Schema::Result::Attribute>

=cut

belongs_to
  attribute => "Interchange6::Schema::Result::Attribute",
  "attributes_id",
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" };

=head2 user_attribute_values

Type: has_many

Related object: L<Interchange6::Schema::Result::UserAttributeValue>

=cut

has_many
  user_attribute_values => "Interchange6::Schema::Result::UserAttributeValue",
  "user_attributes_id",
  { cascade_copy => 0, cascade_delete => 0 };

1;
