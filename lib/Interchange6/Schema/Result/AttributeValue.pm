use utf8;
package Interchange6::Schema::Result::AttributeValue;

=head1 NAME

Interchange6::Schema::Result::AttributeValue

=cut

use Interchange6::Schema::Candy;

=head1 ACCESSORS

=head2 attribute_values_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  primary key

=cut

primary_column attribute_values_id => {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
};

=head2 attributes_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

column attributes_id => {
    data_type      => "integer",
    is_foreign_key => 1,
    is_nullable    => 0,
};

=head2 value

Value name, e.g. red or white.

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

column value => {
    data_type   => "varchar",
    is_nullable => 0,
    size        => 255,
};

=head2 title

Displayed title for attribute value, e.g. Red or White.

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=cut

column title => {
    data_type     => "varchar",
    default_value => "",
    is_nullable   => 0,
    size          => 255,
};

=head2 priority

Display order priority.

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=cut

column priority => {
    data_type     => "integer",
    default_value => 0,
    is_nullable   => 0,
};

=head1 RELATIONS

=head2 attribute

Type: belongs_to

Related object: L<Interchange6::Schema::Result::Attribute>

=cut

belongs_to
  attribute => "Interchange6::Schema::Result::Attribute",
  { attributes_id => "attributes_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" };

=head2 product_attribute_values

Type: has_many

Related object: L<Interchange6::Schema::Result::ProductAttributeValue>

=cut

has_many
  product_attribute_values =>
  "Interchange6::Schema::Result::ProductAttributeValue",
  { "foreign.attribute_values_id" => "self.attribute_values_id" },
  { cascade_copy                  => 0, cascade_delete => 0 };

=head2 user_attribute_values

Type: has_many

Related object: L<Interchange6::Schema::Result::UserAttributeValue>

=cut

has_many
  user_attribute_values => "Interchange6::Schema::Result::UserAttributeValue",
  { "foreign.attribute_values_id" => "self.attribute_values_id" },
  { cascade_copy                  => 0, cascade_delete => 0 };

=head2 navigation_attribute_values

Type: has_many

Related object: L<Interchange6::Schema::Result::NavigationAttributeValue>

=cut

has_many
  navigation_attribute_values =>
  "Interchange6::Schema::Result::NavigationAttributeValue",
  { "foreign.attribute_values_id" => "self.attribute_values_id" },
  { cascade_copy                  => 0, cascade_delete => 0 };

1;
