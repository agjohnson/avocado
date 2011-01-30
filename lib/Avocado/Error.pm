package Avocado::Error;

use Avocado::Response;

my $Errors = {};

sub set {
    my $class = shift;
    my ($error, $func) = @_;

    $Errors->{$error} = $func;
}

sub abort {
    my $class = shift;
    my $error = shift;
    
    # Change status if error is numeric
    if ($error =~ m/^\d+$/) {
        Avocado::Response->status($error);
    }

    if (exists($Errors->{$error})) {
        return &{$Errors->{$error}}($error, @_);
    } else {
        return "<h1>Error</h1><p>Error $error"
    }
}

1;
