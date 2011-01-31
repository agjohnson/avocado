package Avocado::Runner;

use 5.010;
use strict;
use warnings;

use Plack::Runner;
use Avocado::Response;

# Start Plack loop
sub run {
    my $class = shift;

    my $psgi = Plack::Runner->new;
    $psgi->run(\&process);
}

# Processing loop
sub process {
    my $env = shift;

    # Create new request and response
    Avocado::Request->create($env);

    my $res = Avocado::Route->process;
    
    # TODO replace with error response
    my %response = {
        status => 500,
        content_type => 'text/html',
        body => "Invalid response"
    };

    # Not an Avocado::Response? Well fuck off.
    return Avocado::Response->new(%response)
      unless (ref $res eq "Avocado::Response");
    
    # We should have an Avocado::Response, finalize it
    return $res->get();
}

1;
