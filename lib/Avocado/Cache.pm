package Avocado::Cache;

use 5.010;
use strict;
use warnings;

use CHI;

my $Cache = undef;

# Cache function, return closure
sub cache {
    my $class = shift;
    my ($id, $func) = @_;

    return sub {
        my @args = @_;

        my $response = current()->get($id);
        unless (defined $response) {
            $response = &$func(@args);
            current()->set($id, $response);
        }
        return $response;
    }
}

# Return cache object
sub current {
    my $class = shift;

    unless (defined $Cache) {
        $Cache = CHI->new( driver => 'Memory', global => 1 );
    }

    return $Cache;
}

1;
