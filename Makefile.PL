use 5.008009;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Avocado',
    VERSION_FROM      => 'lib/Avocado.pm', # finds $VERSION
    PREREQ_PM         => {
      'Plack::Request' => 0,
      'Plack::Response' => 0,
      'Plack::Runner' => 0,
      'Template' => 0,
      'FindBin' => 0,
      'CHI' => 0
}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Avocado.pm', # retrieve abstract from module
       AUTHOR         => 'Anthony Johnson <anthony@ohess.org>') : ()),
);
