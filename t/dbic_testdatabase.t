use strict;
use warnings;

use Data::Dumper;
use Test::More tests => 19;

use Interchange6::Schema;
use DBICx::TestDatabase;

my $schema = DBICx::TestDatabase->new('Interchange6::Schema');

# create product
my %data = (sku => 'BN004',
            name => 'Green Banana',
            price => 12);

my $product = $schema->resultset('Product')->create(\%data);

isa_ok($product, 'Interchange6::Schema::Result::Product')
    || diag "Create result: $product.";

ok($product->id eq 'BN004', "Testing product id.")
    || diag "Product id: " . $product->id;

# create user
my $user = $schema->resultset('User')->create({username => 'nevairbe@nitesi.de',
                                   email => 'nevairbe@nitesi.de',
                                   password => 'nevairbe'});

isa_ok($user, 'Interchange6::Schema::Result::User')
    || diag "Create result: $user.";

ok($user->id == 1, "Testing user id.")
    || diag "User id: " . $user->id;

# create address
my $address = $schema->resultset('Address')->create({users_id => $user->id});

isa_ok($address, 'Interchange6::Schema::Result::Address')
    || diag "Create result: $address.";

ok($address->id == 1, "Testing address id.")
    || diag "Address id: " . $address->id;

# create session
my %session_data = (sessions_id => 'BN004',
                    session_data => 'Green Banana',
           );

my $session = $schema->resultset('Session')->create(\%session_data);

isa_ok($session, 'Interchange6::Schema::Result::Session')
    || diag "Create result: $session.";

ok($session->id eq 'BN004', "Testing session id.")
    || diag "Session id: " . $session->id;

my $created = $session->created;

ok($created, "Testing session creation time $created.");

my $modified = $session->last_modified;

ok($created eq $modified, "Testing session modification time $modified.");

# countries
use Interchange6::Schema::Populate::CountryLocale;

my $pop_countries = Interchange6::Schema::Populate::CountryLocale->new->records;

my $count = @$pop_countries;

ok($count >= 250, "Test number of countries.")
    || diag "Number of countries: $count.";

my $ret = $schema->populate(Country => $pop_countries);

ok(defined $ret && ref($ret) eq 'ARRAY' && @$ret == @$pop_countries,
   "Result of populating Country.");

$ret = $schema->resultset('Country')->find('DE');

isa_ok($ret, 'Interchange6::Schema::Result::Country');

ok($ret->name eq 'Germany', "Country found for iso_code DE")
    || diag "Result: " . $ret->name;

ok($ret->show_states == 0, "Check show states for DE")
    || diag "Result: " . $ret->show_states;

#states
use Interchange6::Schema::Populate::StateLocale;

my $pop_states = Interchange6::Schema::Populate::StateLocale->new->records;

my $state = $schema->populate(State => $pop_states);

ok(defined $state && ref($state) eq 'ARRAY' && @$state == @$pop_states,
    "Result of populating State.");

$state = $schema->resultset('State')->find(
    { 'state_iso_code' => 'NY' },
);

isa_ok($state, 'Interchange6::Schema::Result::State');

ok($state->name eq 'New York', "State found for state_iso_code NY")
    || diag "Result: " . $state->name;

ok($state->country_iso_code eq 'US', "Check shows country_iso_code for NY")
    || diag "Result: " . $state->country_iso_code;


