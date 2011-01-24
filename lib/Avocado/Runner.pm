package Avocado::Runner;

use Plack::Runner;

sub run {
    my $class = shift;

    my $psgi = Plack::Runner->new;
    $psgi->run(\&process);
}

sub process {
    my $env = shift;

    # Create new request and response
    Avocado::Request->create($env);
    Avocado::Response->create(200);

    my $res = Avocado::Route->process;

    return render_response($res);
}

sub render_response {
    my $obj = shift;

    # Decide response based on object type
    if (ref $obj eq "") {
        Avocado::Response->body("$obj");
    }
    elsif (ref $obj eq "ARRAY") {
        for my $elm ($obj) {
            # Build response body
            my $body = "";
            $body .= "$elm";    
            Avocado::Response->body($body);
        }
    }
    else {
        Avocado::Response->body("$obj");
    }

    return Avocado::Response->get;
}

1;
