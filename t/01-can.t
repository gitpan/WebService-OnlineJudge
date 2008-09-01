use Test::More tests => 5;

use WebService::OnlineJudge;

# tests the existance of the API
my $m = 'WebService::OnlineJudge';

can_ok($m, 'new');
can_ok($m, 'submissions');
can_ok($m, 'problems');
can_ok($m, 'users');
can_ok($m, 'contests');
