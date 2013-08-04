#!perl -Tw

use strict;

use Test::More tests=>49;

use MODS::Record qw(xml_string);
use IO::File;

my $mods;

ok($mods = MODS::Record->new,"new");
is($mods->version,"3.5","version");
ok($mods->version("3.3"),"set version");
is($mods->version,"3.3","version");

my $abstract;

ok($abstract = $mods->add_abstract("test123",lang=>'eng',contentType=>'text/plain'),"set abstract");
is($abstract,"test123","test abstract body");
is($abstract->lang,"eng","test abstract lang");
is($abstract->contentType,"text/plain","test abstract contentType");

ok($abstract = $mods->add_abstract(MODS::Element::Abstract->new(_body=>'test123',lang=>'eng',contentType=>'text/plain')),"set abstract");
is($abstract,"test123","test abstract body");
is($abstract->lang,"eng","test abstract lang");
is($abstract->contentType,"text/plain","test abstract contentType");

ok($abstract = $mods->add_abstract(sub { my $o = shift; $o->body('test123'); $o->lang('eng'); $o->contentType('text/plain')}),"set abstract");
is($abstract,"test123","test abstract body");
is($abstract->lang,"eng","test abstract lang");
is($abstract->contentType,"text/plain","test abstract contentType");

$abstract = $mods->add_abstract();
ok($abstract->body('test123'));
ok($abstract->lang('eng'));
ok($abstract->contentType('text/plain'));
is($abstract,"test123","test abstract body");
is($abstract->lang,"eng","test abstract lang");
is($abstract->contentType,"text/plain","test abstract contentType");

my @abstract;
ok(@abstract = $mods->get_abstract,"get abstract");
is(@abstract,4,"count abstract");

ok($abstract = $mods->abstract([MODS::Element::Abstract->new(_body=>'test123',lang=>'eng',contentType=>'text/plain')]),"set abstract");
is($abstract->[0],"test123","test abstract body");
is($abstract->[0]->lang,"eng","test abstract lang");
is($abstract->[0]->contentType,"text/plain","test abstract contentType");

ok(@abstract = $mods->get_abstract,"get abstract");
is(@abstract,1,"count abstract");

is($mods->get_abstract(lang=>'eng'),"test123","get one abstract");
is($mods->get_abstract(sub { shift->lang eq 'eng'}),"test123","get one abstract");

my $access;
ok($access = $mods->add_accessCondition('test'),"set string accessCondition");
is($access,'test');
ok($access = $mods->add_accessCondition(xml_string('<test/>')),"set XML accessCondition");
is($access,'<test/>');

my @access;
ok(@access = $mods->get_accessCondition,"get accessCondition");
is(@access,2,"count accessCondition");
is(@access = $mods->set_accessCondition(),2,"set accessCondition");
is(@access = $mods->set_accessCondition(undef),0,"set accessCondition");
is(@access = $mods->set_accessCondition(MODS::Element::AccessCondition->new(_body=>'test')),1,"set accessCondition");
is(@access = $mods->set_accessCondition([MODS::Element::AccessCondition->new(_body=>'test')]),1,"set accessCondition");

my $collection;
ok($collection = MODS::Record->from_xml(IO::File->new("t/mods.xml")),"from_xml");
is($collection->get_mods->get_titleInfo->get_title,"Telescope Peak from Zabriskie Point","titleInfo/title");
is($collection->get_mods->get_titleInfo(type=>'alternative')->get_title,"Telescope PK from Zabriskie Pt.","titleInfo[type=\"alternative\"]/title");

ok($collection = MODS::Record->from_json(IO::File->new("t/mods.json")),"from_json");
is($collection->get_mods->get_titleInfo->get_title,"Telescope Peak from Zabriskie Point","titleInfo/title");
is($collection->get_mods->get_titleInfo(type=>'alternative')->get_title,"Telescope PK from Zabriskie Pt.","titleInfo[type=\"alternative\"]/title");

SKIP: {
 my $fh = IO::File->new('>t/mods_out.xml');
 skip "Can't write to system",1 unless defined $fh;
 my $xml;
 ok($xml = $collection->as_xml(xml_prolog=>1),"as_xml");
 print $fh $xml;
 $fh->close();
}