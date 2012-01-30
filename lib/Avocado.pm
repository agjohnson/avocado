package Avocado;

use 5.008009;
use strict;
use warnings;

our $VERSION = '0.01.2';

use Avocado::Cache;
use Avocado::Context;
use Avocado::Error;
use Avocado::Response;
use Avocado::Request;
use Avocado::Route;
use Avocado::Runner;
use Avocado::View;

use base 'Exporter';

our @EXPORT = qw/
  cache
  c
  abort error redirect
  request
  response status body content_type
  get post
  setup run
  template render
/;

sub cache { Avocado::Cache->cache(@_); }

sub c { Avocado::Context->c(@_); }

sub abort { Avocado::Error->abort(@_); }
sub error { Avocado::Error->set(@_); }
sub redirect { Avocado::Error->redirect(@_); }

sub request { Avocado::Request->get(@_); }

sub response { Avocado::Response->get(@_); }
sub status { Avocado::Response->status(@_); }
sub content_type { Avocado::Response->content_type(@_); }
sub body { Avocado::Response->body(@_); }

sub get { Avocado::Route->add('GET', @_); }
sub post { Avocado::Route->add('POST', @_); }

sub setup { Avocado::Runner->setup(@_); }
sub run { Avocado::Runner->run(@_); }

sub template { Avocado::View->template(@_); }
sub render { Avocado::View->render(@_); }

1;
__END__

=head1 NAME

Avocado

=head1 DESCRIPTION

Avocado is syntactic sugar built on top of Plack that helps power the 
ohess.org website. Don't use this though, it was only a programming exercise.
If you are masochistic, you can find the source code -- an example of Avocado 
usage -- on github.

You were warned.

=head1 SEE ALSO

L<http://github.com/agjohnson/ohess>

=head1 AUTHOR

Anthony Johnson, E<lt>aj@ohess.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2011 Anthony Johnson <aj@ohess.org>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

=cut
