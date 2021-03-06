use utf8;

package Interchange6::Schema::Result::Cart;

=head1 NAME

Interchange6::Schema::Result::Cart

=cut

use Interchange6::Schema::Candy -components =>
  [qw(InflateColumn::DateTime TimeStamp)];

=head1 ACCESSORS

=head2 carts_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'carts_carts_id_seq'
  primary key

=cut

primary_column carts_id => {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "carts_carts_id_seq",
};

=head2 name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=cut

column name => {
    data_type     => "varchar",
    default_value => "",
    is_nullable   => 0,
    size          => 255,
};

=head2 users_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

column users_id => {
    data_type      => "integer",
    is_foreign_key => 1,
    is_nullable    => 1,
};

=head2 sessions_id

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 1
  size: 255

=cut

column sessions_id => {
    data_type      => "varchar",
    is_foreign_key => 1,
    is_nullable    => 1,
    size           => 255,
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

=head2 approved

  data_type: 'boolean'
  is_nullable: 1

=cut

column approved => {
    data_type   => "boolean",
    is_nullable => 1,
};

=head2 status

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 32

=cut

column status => {
    data_type     => "varchar",
    default_value => "",
    is_nullable   => 0,
    size          => 32,
};

=head1 UNIQUE CONSTRAINTS

=head2 carts_name_sessions_id

On ( name, sessions_id )

=cut

unique_constraint carts_name_sessions_id => [qw/ name sessions_id /];

=head1 RELATIONS

=head2 cart_products

Type: has_many

Related object: L<Interchange6::Schema::Result::CartProduct>

=cut

has_many
  cart_products => "Interchange6::Schema::Result::CartProduct",
  { "foreign.carts_id" => "self.carts_id" },
  { cascade_copy       => 0, cascade_delete => 0 };

=head2 session

Type: belongs_to

Related object: L<Interchange6::Schema::Result::Session>

=cut

belongs_to
  session => "Interchange6::Schema::Result::Session",
  { sessions_id   => "sessions_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" };

=head2 user

Type: belongs_to

Related object: L<Interchange6::Schema::Result::User>

=cut

belongs_to
  user => "Interchange6::Schema::Result::User",
  { users_id      => "users_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" };

1;
