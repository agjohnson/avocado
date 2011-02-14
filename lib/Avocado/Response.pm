package Avocado::Response;

use 5.010;
use strict;
use warnings;

use Plack::Response;

my @Fields = qw/content_type status body location/;

# Instantiate
sub new {
    my ($class, %args) = @_;

    my $self = {
        status => 200,
        content => "",
        %args
    };

    # Set up Plack response
    $self->{response} = Plack::Response->new($self->{status});

    for my $field (@Fields) {
        if (defined $self->{$field}) {
            no strict 'refs';
            &{"Plack\::Response\::$field"}($self->{response}, $self->{$field});
        }
    }

    bless $self, $class;
    return $self;
}

# Create methods for plack response object
for my $field (@Fields) {
    
    no strict 'refs';

    *{"Avocado\::Response\::$field"} = sub {
        my ($self, $value) = @_;

        if (defined $value) {
            &{"Plack\::Response\::$field"}($self->{response}, $value);
        }
        
        return &{"Plack\::Response\::$field"}($self->{response}); 
    };
}

# Create and finalize Plack response
sub get {
    my $self = shift;
    return $self->{response}->finalize;
}

1;
