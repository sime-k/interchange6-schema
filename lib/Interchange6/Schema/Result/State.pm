use utf8;

package Interchange6::Schema::Result::State;

=head1 NAME

Interchange6::Schema::Result::State

=cut

use Interchange6::Schema::Candy;

=head1 DESCRIPTION

ISO 3166-2 codes for sub_country identification "states"

B<scope:> Internal sorting field.

B<country_iso_code:> Two letter country code such as 'SI' = Slovenia.

B<state_iso_code:> Alpha state code such as 'NY' = New York.

B<name:>  Full state name.

B<priority:>  Display sorting.

B<active:>  Is this state a shipping destination?  Default is true.

=head1 ACCESSORS

=head2 states_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  primary key

=cut

primary_column states_id =>
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 };

=head2 scope

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 32

=cut

column scope =>
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 32 };

=head2 country_iso_code

  data_type: 'char'
  is_foreign_key: 1
  is_nullable: 0
  size: 2

=cut

column country_iso_code =>
  { data_type => "char", is_foreign_key => 1, is_nullable => 0, size => 2 };

=head2 state_iso_code

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 6

=cut

column state_iso_code =>
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 6 };

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
    size          => 255
};

=head2 priority

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=cut

column priority =>
  { data_type => "integer", default_value => 0, is_nullable => 0 };

=head2 active

  data_type: 'boolean'
  default_value: 1
  is_nullable: 0

=cut

column active =>
  { data_type => "boolean", default_value => 1, is_nullable => 0 };

=head1 UNIQUE CONSTRAINT

=head2 states_state_country

=over 4

=item * L</country_iso_code>

=item * L</state_iso_code>

=back

=cut

unique_constraint states_state_country => [qw/country_iso_code state_iso_code/];

=head1 RELATIONS

=head2 country

Type: belongs_to

Related object: L<Interchange6::Schema::Result::Country>

=cut

belongs_to
  country => "Interchange6::Schema::Result::Country",
  "country_iso_code",
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" };

=head2 zone_states

Type: has_many

Related object L<Interchange6::Schema::Result::ZoneState>

=cut

has_many
  zone_states => "Interchange6::Schema::Result::ZoneState",
  "states_id",
  { cascade_copy => 0, cascade_delete => 0 };

=head2 zones

Type: many_to_many

Composing rels: L</zone_state> -> zone

=cut

many_to_many zones => "zone_state", "zone";

1;
