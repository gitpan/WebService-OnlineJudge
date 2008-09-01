use Test::More tests => 8;

use WebService::OnlineJudge;

diag ("Please skip tests if your Internet connection is not active");
# tests the existance of the API
my $ws = WebService::OnlineJudge->new();

my $submissions = $ws->submissions();
like($submissions, qr/^\d+$/);
cmp_ok($submissions, '>=', 6620750);

my $problems = $ws->problems();
like($problems, qr/^\d+$/);
cmp_ok($problems, '>=', 2381);

my $users = $ws->users();
like($users, qr/^\d+$/);
cmp_ok($users, '>=', 77066);

my $contests = $ws->contests();
like($contests, qr/^\d+$/);
cmp_ok($contests, '>=', 211);
