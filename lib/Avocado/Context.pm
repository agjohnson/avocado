package Avocado::Context;

my $CONTEXT = {};

sub clear {
  my $class = shift;
  $CONTEXT = {};
}

sub c {
  my $class = shift;
  my ($key, $value) = @_;

  if ($value) {
    $CONTEXT->{$key} = $value;
  }
  else {
    return $CONTEXT->{$key};
  }
}

1;
