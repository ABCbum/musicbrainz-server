package t::MusicBrainz::Server::Data::Utils;
use Test::Routine;
use Test::Moose;
use Test::More;

use MusicBrainz::Server::Data::Utils;

use MusicBrainz::Server::Context;
use MusicBrainz::Server::Test;

with 't::Context';

test all => sub {

my $test = shift;
MusicBrainz::Server::Test->prepare_test_database($test->c, '+artisttype');

my $date = MusicBrainz::Server::Data::Utils::partial_date_from_row(
    { a_year => 2008, a_month => 1, a_day => 2 }, 'a_');

is ( $date->year, 2008 );
is ( $date->month, 1 );
is ( $date->day, 2 );

my @result = MusicBrainz::Server::Data::Utils::query_to_list(
    $test->c->sql, sub { $_[0] }, "SELECT * FROM artist_type
                        WHERE id IN (1, 2) ORDER BY id");
is ( scalar(@result), 2 );
is ( $result[0]->{id}, 1 );
is ( $result[1]->{id}, 2 );

my ($result, $hits) = MusicBrainz::Server::Data::Utils::query_to_list_limited(
    $test->c->sql, 0, 1, sub { $_[0] }, "SELECT * FROM artist_type
                              WHERE id IN (1, 2) ORDER BY id");
@result = @{$result};
is ( scalar(@result), 1 );
is ( $hits, 2 );
is ( $result[0]->{id}, 1 );

my $order_by;

$order_by = MusicBrainz::Server::Data::Utils::order_by(
    undef, "1", { "1" => "a, b", "2" => "c, b" });
is ( $order_by, "a, b" );

$order_by = MusicBrainz::Server::Data::Utils::order_by(
    "1", "1", { "1" => "a, b", "2" => "c, b" });
is ( $order_by, "a, b" );

$order_by = MusicBrainz::Server::Data::Utils::order_by(
    "3", "1", { "1" => "a, b", "2" => "c, b" });
is ( $order_by, "a, b" );

$order_by = MusicBrainz::Server::Data::Utils::order_by(
    "2", "1", { "1" => "a, b", "2" => "c, b" });
is ( $order_by, "c, b" );

$order_by = MusicBrainz::Server::Data::Utils::order_by(
    "-1", "1", { "1" => "a, b", "2" => "c, b" });
is ( $order_by, "a DESC, b DESC" );

$order_by = MusicBrainz::Server::Data::Utils::order_by(
    "-2", "1", { "1" => "a, b", "2" => "c, b" });
is ( $order_by, "c DESC, b DESC" );

$order_by = MusicBrainz::Server::Data::Utils::order_by(
    "-3", "1", { "1" => "a, b", "2" => "c, b" });
is ( $order_by, "a, b" );

};

1;
