package Avocado::View;

use Avocado::Response;

use Template;
use FindBin;
use Plack::Response;

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

    return $output;
}

1;
