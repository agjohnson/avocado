package Avocado::Route;

use Avocado::Request;
use Avocado::View;
use Data::Dumper;

my $routes = {};

sub get {
    my $class = shift;
    my ($name, $path, $func) = @_;

    $routes->{$name} = {
        path => $path,
        func => $func
    };
}

sub process {
    my $class = shift;

    my $path = Avocado::Request->get->path_info;

    # Iterate through routes
    foreach $route (keys %{$routes}) {
        my $route_path = $routes->{$route}->{path};
        if (my @args = ($path =~ m#$route_path#)) {
            return &{$routes->{$route}->{func}}(@args);
        }
    }

    return undef;
}

1;
