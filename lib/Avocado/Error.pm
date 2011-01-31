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
        $content = &{$Errors->{$error}}($error, @_);
    } else {
        $content = "<h1>Error</h1><p>Error $error"
    }

    return Avocado::Response->new(
        content_type => 'text/html',
        status => $error,
        body => $content
    );
}

1;
