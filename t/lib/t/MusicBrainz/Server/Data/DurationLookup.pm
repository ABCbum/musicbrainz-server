package t::MusicBrainz::Server::Data::DurationLookup;
use Test::Routine;
use Test::Moose;
use Test::More;
use Test::Memory::Cycle;

use MusicBrainz::Server::Data::DurationLookup;

use MusicBrainz::Server::Context;
use MusicBrainz::Server::Test;
use Sql;

with 't::Context';

test all => sub {

my $test = shift;
MusicBrainz::Server::Test->prepare_test_database($test->c, '+data_durationlookup');

my $sql = $test->c->sql;
my $raw_sql = $test->c->raw_sql;

my $lookup_data = MusicBrainz::Server::Data::DurationLookup->new(c => $test->c);
does_ok($lookup_data, 'MusicBrainz::Server::Data::Role::Context');
memory_cycle_ok($lookup_data);

my $result = $lookup_data->lookup("1 10 323860 182 36697 68365 94047 125922 180342 209172 245422 275887 300862", 10000);
is ( defined $result->[0] && $result->[0]->medium->tracklist_id, 1 );
is ( defined $result->[0] && $result->[0]->distance, 0 );
is ( defined $result->[0] && $result->[0]->medium_id, 3 );

memory_cycle_ok($lookup_data);
memory_cycle_ok($result);

$result = $lookup_data->lookup("1 10 205220 150 5646 32497 60461 75807 100902 106930 128979 144938 170007", 10000);
is ( defined $result->[0] && $result->[0]->medium->tracklist_id, 2 );
is ( defined $result->[0] && $result->[0]->distance, 0 );
is ( defined $result->[0] && $result->[0]->medium_id, 4 );

memory_cycle_ok($lookup_data);
memory_cycle_ok($result);

};

1;
