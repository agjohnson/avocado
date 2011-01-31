package Avocado::View;

use 5.010;
use strict;
use warnings;

use Avocado::Response;

use Template;
use FindBin;

my $PATH = $FindBin::Bin . "/view";

sub template {
    my $class = shift;
    my $template = shift;
    my $args = shift;

    my $output = "";

    my $t = Template->new({
        INCLUDE_PATH => $PATH,
    });

    $t->process($template, $args, \$output) || die $t->error();

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
