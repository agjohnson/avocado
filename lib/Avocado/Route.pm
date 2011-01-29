package Avocado::Route;

use 5.010;
use strict;
use warnings;

use Avocado::Request;
use Avocado::View;
use Data::Dumper;

my @Routes;

# Add route to Routes array
sub add {
    my $class = shift;
    my ($method, $path, $func) = @_;

    push(@Routes, {
        path => $path,
        func => $func,
        method => $method
    });
}

# Find first route that matches, return return value
sub process {
    my $class = shift;

    my $path = Avocado::Request->get->path_info;
    my $method = Avocado::Request->get->method;

    # Iterate through routes, next on wrong method
    foreach my $route (@Routes) {
        next if (!$route->{method} eq $method);

        my $route_path = $route->{path};
        if (my @args = ($path =~ m#$route_path#)) {
            return &{$route->{func}}(@args);
        }
    }

    return $method;
}

1;
