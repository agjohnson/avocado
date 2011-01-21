package Avocado::Runner;

use Plack::Runner;

sub setup {
    my $class = shift;
    my $env = shift;

    # Create new request and response
    Avocado::Request->create($env);
    Avocado::Response->create(200);
}

sub run {
    my $class = shift;
    my $func = shift;

    my $psgi = Plack::Runner->new;
    $psgi->run($func);
}

1;
