package Avocado::View;

use 5.010;
use strict;
use warnings;

use Avocado::Response;

use Template;
use FindBin;
use Carp;

my $PATH = $FindBin::Bin . "/view";

# Return response rendered from TT2 template
sub template {
    my ($class, $template, $args) = @_;

    # Try to process the template, croak on errors, return response
    my $output = "";
    my $t = Template->new({
        INCLUDE_PATH => $PATH,
    }) or croak("Error setting up template processor");

    $t->process($template, $args, \$output)
      or croak(sprintf("Template error: %s", $t->error()));

    return Avocado::Response->new(
        status => 200,
        content_type => 'text/html',
        body => $output
    );
}

# Render object as response
sub render {
    my ($class, $obj) = @_;

    # TODO render hashes as json?
    my $content = "$obj";
    
    return Avocado::Response->new(
        status => 200,
        content_type => 'text/plain',
        body => $content
    );
}

1;
