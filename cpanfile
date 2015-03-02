requires 'perl', 'v5.10.1';

on 'test', sub {
  requires 'Test::Deep', '0.112';
  requires 'Test::Exception', '0.32';
  requires 'Test::More', '1.001003';
  requires 'Test::Pod', 0;
};


requires 'Carp', '1.3301';
requires 'IO', '1.25';
requires 'JSON', '2.90';
requires 'Moo', '1.007000';
requires 'XML::Parser', '2.44';
