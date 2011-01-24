package Avocado::Response;

use Plack::Response;

# Class object to store response object
my $RES = undef;

sub create {
    my $class = shift;
    my $status = shift || 200;

    $RES = Plack::Response->new($status);

    $class->content_type('text/html');

    return $RES;
}

sub get {
    return $RES->finalize;
}

sub status {
    my $class = shift;
    my $status = shift;

    if ($status) {
        $RES->status($status);
    }
    else {
        return $RES->status;
    }
}

sub content_type {
    my $class = shift;
    my $type = shift;

    if ($type) {
        $RES->content_type($type);
    }
    else {
        return $RES->content_type;
    }
}

sub body {
    my $class = shift;
    my $arg = shift;

    if ($arg) {
        $RES->body($arg);
    }
    else {
        return $RES->body;
    }
}

1;
