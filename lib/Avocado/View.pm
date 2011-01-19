package Avocado::View;

use Avocado::Response;

use Template;
use FindBin;
use Plack::Response;

my $path = $FindBin::Bin . "/Dc/view";

sub render {
  my $self = shift;
  my $template = shift;
  my $args = shift;

  my $output = "";

  my $t = Template->new({
    INCLUDE_PATH => $path,
  });

  $t->process($template, $args, \$output) || die $t->error();

  Avocado::Response->body($output);

  return Avocado::Response->get;
}

1;
