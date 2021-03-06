use utf8;
package Interchange6::Schema::Result::Address;

=head1 NAME

Interchange6::Schema::Result::Address

=cut

use Interchange6::Schema::Candy -components =>
  [qw(InflateColumn::DateTime TimeStamp)];

=head1 ACCESSORS

=head2 addresses_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'addresses_addresses_id_seq'
  primary key

=cut

primary_column addresses_id => {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "addresses_addresses_id_seq",
};

=head2 users_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

column users_id => {
    data_type      => "integer",
    is_foreign_key => 1,
    is_nullable    => 0,
};

=head2 type

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 16

=cut

column type => {
    data_type     => "varchar",
    default_value => "",
    is_nullable   => 0,
    size          => 16,
};

=head2 archived

  data_type: 'boolean'
  default_value: 0
  is_nullable: 0

=cut

column archived => {
    data_type     => "boolean",
    default_value => 0,
    is_nullable   => 0,
};

=head2 first_name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=cut

column first_name => {
    data_type     => "varchar",
    default_value => "",
    is_nullable   => 0,
    size          => 255,
};

=head2 last_name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=cut

column last_name => {
    data_type     => "varchar",
    default_value => "",
    is_nullable   => 0,
    size          => 255,
};

=head2 company


  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=cut

column company => {
    data_type     => "varchar",
    default_value => "",
    is_nullable   => 0,
    size          => 255,
};

=head2 address

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=cut

column address => {
    data_type     => "varchar",
    default_value => "",
    is_nullable   => 0,
    size          => 255,
};

=head2 address_2

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=cut

column address_2 => {
    data_type     => "varchar",
    default_value => "",
    is_nullable   => 0,
    size          => 255,
};

=head2 postal_code

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=cut

column postal_code => {
    data_type     => "varchar",
    default_value => "",
    is_nullable   => 0,
    size          => 255,
};

=head2 city

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=cut

column city => {
    data_type     => "varchar",
    default_value => "",
    is_nullable   => 0,
    size          => 255,
};

=head2 phone

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 32

=cut

column phone => {
    data_type     => "varchar",
    default_value => "",
    is_nullable   => 0,
    size          => 32,
};

=head2 states_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

column states_id => {
    data_type      => "integer",
    is_foreign_key => 1,
    is_nullable    => 1,
};

=head2 country_iso_code

  data_type: 'char'
  is_foreign_key: 1
  is_nullable: 0
  size: 2

=cut

column country_iso_code => {
    data_type      => "char",
    is_foreign_key => 1,
    is_nullable    => 0,
    size           => 2,
};

=head2 created

  data_type: 'datetime'
  set_on_create: 1
  is_nullable: 0

=cut

column created => {
    data_type     => "datetime",
    set_on_create => 1,
    is_nullable   => 0,
};

=head2 last_modified

  data_type: 'datetime'
  set_on_create: 1
  set_on_update: 1
  is_nullable: 0

=cut

column last_modified => {
    data_type     => "datetime",
    set_on_create => 1,
    set_on_update => 1,
    is_nullable   => 0,
};

=head1 RELATIONS

=head2 orderlines_shipping

Type: has_many

Related object: L<Interchange6::Schema::Result::OrderlinesShipping>

=cut

has_many
  orderlines_shipping => "Interchange6::Schema::Result::OrderlinesShipping",
  { "foreign.addresses_id" => "self.addresses_id" },
  { cascade_copy           => 0, cascade_delete => 0 };

=head2 orders

Type: has_many

Related object: L<Interchange6::Schema::Result::Order>

=cut

has_many
  orders => "Interchange6::Schema::Result::Order",
  { "foreign.billing_addresses_id" => "self.addresses_id" },
  { cascade_copy                   => 0, cascade_delete => 0 };

=head2 user

Type: belongs_to

Related object: L<Interchange6::Schema::Result::User>

=cut

belongs_to
  user => "Interchange6::Schema::Result::User",
  { users_id      => "users_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" };

=head2 state

Type: belongs_to

Related object: L<Interchange6::Schema::Result::State>

=cut

belongs_to
  state => "Interchange6::Schema::Result::State",
  { states_id     => "states_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" };

=head2 country

Type: belongs_to

Related object: L<Interchange6::Schema::Result::Country>

=cut

belongs_to
  country => "Interchange6::Schema::Result::Country",
  "country_iso_code",
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" };

=head2 orderlines

Type: many_to_many

Composing rels: L</orderlines_shipping> -> orderline

=cut

many_to_many orderlines => "orderlines_shipping", "orderline";

1;
