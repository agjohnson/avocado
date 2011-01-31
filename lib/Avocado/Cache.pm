package Avocado::Cache;

use 5.010;
use strict;
use warnings;

use Avocado::Request;

use CHI;

my $Cache = undef;

# Cache function, return closure
sub cache {
    my $class = shift;
    my $func = shift;

    return sub {
        my @args = @_;
        my $id = get_cache_id();

        my $response = current()->get($id);
        unless (defined $response) {

            $response = &$func(@args);

            if (ref $response eq "Avocado::Response") {
                current()->set($id, $response)
                  if ($response->status() == 200);
            }

        }
        return $response;
    }
}

# Return cache object
sub current {
    my $class = shift;

    unless (defined $Cache) {
        $Cache = CHI->new( driver => 'File', root_dir => './cache', global => 1 );
    }

    return $Cache;
}

# Get a unique id based on path_info
sub get_cache_id {
    my $id = Avocado::Request->get()->path_info;
    $id =~ s/[^A-Za-z0-9\_\-]/_/;
    return $id;
}

1;
