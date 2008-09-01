#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'WebService::OnlineJudge' );
}

diag( "Testing WebService::OnlineJudge $WebService::OnlineJudge::VERSION, Perl $], $^X" );
