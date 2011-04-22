package Avocado::Error;

use 5.010;
use strict;
use warnings;

use Avocado::Response;

my $Errors = {};

# Add error handler to Errors
sub set {
    my $class = shift;
    my ($error, $func) = @_;

    $Errors->{$error} = $func;
}

# Return abort response
sub abort {
    my $class = shift;
    my $error = shift;
    my $content;
    
    # Change status if error is numeric
    if ($error !~ m/^\d+$/) {
        return Avocado::Response->new(
            content_type => 'text/html',
            status => 500,
            content => "Yo dawg..."
        );
    }

    if (exists($Errors->{$error})) {
        my $error_res = &{$Errors->{$error}}($error, @_);
        
        die("Error response not an Avocado::Response")
          unless (ref $error_res eq "Avocado::Response");

        $error_res->status($error);

        return $error_res;
    } else {
        return Avocado::Response->new(
            content_type => 'text/html',
            status => $error,
            body => "<h1>Error</h1><p>Error $error"
        );
    }

}

# Return redirect response
sub redirect {
    my $class = shift;
    my $url = shift;

    return Avocado::Response->new(
        content_type => 'text/html',
        status => 302,
        location => $url
    );
}

1;
