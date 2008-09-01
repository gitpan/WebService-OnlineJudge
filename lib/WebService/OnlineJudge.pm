package WebService::OnlineJudge;
use warnings;
use strict;

use WWW::Mechanize;
use Carp;

our $VERSION = '0.01';

sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
    $self->_init();
    return $self;
}

sub _init {
    my $self = shift;

    # first we get to the UVa's website
    my $mech = WWW::Mechanize->new(quiet => 1);
    $mech->get('http://icpcres.ecs.baylor.edu/onlinejudge/');
    if ( $mech->success() ) {

        # then we try to parse its contents
        # the best way we can.
        my $html = $mech->content;
        my @values =
            $html =~ m{<h1 style="margin-top:-20px;margin-bottom:-5px;">(\d+)</h1>}g;
        if(@values < 4) {
            croak "Error finding main values. Site does not appear to be correct.\n";
        }
        else {
            $self->{'_submissions'} = $values[0];
            $self->{'_problems'} = $values[1];
            $self->{'_users'} = $values[2];
            $self->{'_contests'} = $values[3];
        }
    }
    else {
        croak "Error connecting to Valladolid Online Judge System.\n";
    }
}

sub submissions {
    my $self = shift;
    return $self->{'_submissions'};
}

sub problems {
    my $self = shift;
    return $self->{'_problems'};
}

sub users {
    my $self = shift;
    return $self->{'_users'};
}

sub contests {
    my $self = shift;
    return $self->{'_contests'};
}


1; # End of WebService::OnlineJudge

__END__

=head1 NAME

WebService::OnlineJudge - Perl interface to UVa Online Judge System (Valladolid Programming Competition)


=head1 VERSION

Version 0.01


=head1 SYNOPSIS

    use WebService::OnlineJudge;
    
    my $ws = WebService::OnlineJudge->new();
    
    # you can get current status of the site
    print 'Current submissions: ' . $ws->submissions() . "\n";
    print 'Current problems: '    . $ws->problems()    . "\n";
    print 'Current users: '       . $ws->users()       . "\n";
    print 'Current contests: '    . $ws->contests()    . "\n";


=begin left


for me to know, for users to expect in future versions!

the rest is still under development...
    
    # you can get information on contests 
    # These always return a WebService::OnlineJudge::Contest object.
    # Refer to its documentation for more information on available methods
    my $contest = $ws->running_contests();
    $contest = $ws->coming_contests();
    $contest = $ws->past_contests();

    # you can browse available problems
    my $problem = $ws->get_problem(201);
    $problem = $ws->get_next_problem();

    # this returns a WebService::OnlineJudge::Problem object.
    # Refer to its documentation for more information on available methods
    $problem->title();
    $problem->time_limit();
    $problem->description();
    $problem->input();
    $problem->sample_input();
    $problem->output();
    $problem->sample_output();
    $problem->submissions();
    $problem->solving_per_submissions();
    $problem->users();
    $problem->solving_per_users();
    
    # you can get statistics
    $ws->stats(2008);
    $ws->stats( { year => 2003,       # or 'total' for the sum of all years
                  month => 'October', # or 10 (in case of october)
                  language => 'C++',  # or 'all' for the sum of all languages
                  percent => 1,       # returns result in percentage
                });
    $ws->stats_image(); # returns png statistics image

    # you can even send them a message
    $ws->contact( { name => 'My Name',
                    email => 'my@email',
                    subject => 'my subject',
                    message => 'this is my message',
                  });

    # you can also get the current ranklist
    # this returns a WebService::OnlineJudge::Ranklist object
    # Refer to its documentation for more information on available methods
    $ws->ranklist(10);

    # you can login, logout, ask for your password or register a new user
    $ws->login( 'username', 'password' )
        or die "Incorrect username or password\n";

    $ws->lost_password( 'username', 'email' );

    $ws->register( { name => 'myname',
                     username => 'myusername',
                     email => 'my@email',
                     password => 'mypassword',
                     verify => 'mypassword',  # optional field
                     id => 'myonlinejudgeid', # default is '00000'
                     results => 1,            # optional field
                   });
    ...


=end left



=head1 DESCRIPTION

Programming competitions happen everywhere, but one of the most famous is the Valladolid University's (UVa) International Programming Contest. Unfortunately you can't submit code in Perl (there's a funny story on Perl being banned from UCLA's competition for making problems too easy to solve in http://groups.google.com/group/comp.lang.perl.misc/msg/2cb6cb1134f84d81). Still, that doesn't mean you can't use Perl to provide a nice interface to the contest's information.


=head1 METHODS

=head2 new()

Returns a new WebService::OnlineJudge object.

=head2 submissions()

Returns the total number of submissions in the UVa System

=head2 problems()

Returns the total number of available problems in the UVa System

=head2 users()

Returns the total number of users registered in the UVa System

=head2 contests()

Returns the total number of contests available in the UVa System


=head1 AUTHOR

Breno G. de Oliveira, C<< <garu at cpan.org> >>

=head1 BUGS AND LIMITATIONS

The Valladolid OnlineJudge website appears to be not mature enough in its own interface, so don't be surprised if something suddenly stops working - just drop me a line via email or RT and I'll try to adjust this module to it as soon as possible.

Please report any bugs or feature requests to C<bug-webservice-onlinejudge at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WebService-OnlineJudge>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WebService::OnlineJudge


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WebService-OnlineJudge>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WebService-OnlineJudge>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WebService-OnlineJudge>

=item * Search CPAN

L<http://search.cpan.org/dist/WebService-OnlineJudge>

=back


=head1 ACKNOWLEDGEMENTS

I'd like to thank Bruno C. Buss for inspiring the creation of this module and helping with the API. He'll probably be the maintainer of this in the future (or at least a solid bug/bugfix RT poster =)


=head1 COPYRIGHT & LICENSE

Copyright 2008 Breno G. de Oliveira, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

