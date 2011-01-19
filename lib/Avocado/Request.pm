package Avocado::Request;

use Plack::Request;

my $REQ = undef;

sub create {
  my $class = shift;
  my $env = shift;

  $REQ = Plack::Request->new($env);

  return $REQ;
}

sub get {
  my $class = shift;
  return $REQ;
}

1;
