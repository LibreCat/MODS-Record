NAME
    MODS::Record - Perl extension for handling MODS records

SYNOPSIS
     use MODS::Record qw(xml_string);

     my $mods = MODS::Record->new;

     my $collection = MODS::Collection->new;

     my $mods = $collection->add_mods(ID => '1234');

     $mods->add_abstract("Hello", lang => 'eng');
     $mods->add_abstract("Bonjour", lang => 'fra');

     # Set a deeply nested field...
     $mods->add_language()->add_languageTerm('eng');

     # Set a list of deeply nested fields...
     $mods->add_location(sub {
            $_[0]->add_physicalLocation('here');
            $_[0]->add_shelfLocation('here too');
            $_[0]->add_url('http://here.org/there');
     }); 

     # Set an inline XML extension...
     $mods->add_accessCondition(xml_string("<x:foo><x:bar>21212</x:bar></x:foo>"));

     # Retrieve a field by a filter...
     $mods->get_abstract(lang => 'fra')->body("Bonjour :)");
     $mods->get_abstract(lang => 'fra')->contentType('text/plain');

     for ($mods->get_abstract(lang => 'fra')) {
            printf "%s\n" , $_->body;
     }

     # Set a field to a new value
     my @newabstract;
     for ($mods->get_abstract) {
            push @newabstract, $_ unless $_->lang eq 'fra';
     }
     $mods->set_abstract(@newabstract);

     # Clear all abstracts;
     $mods->set_abstract(undef);

     # Serialize
     print $mods->as_json(pretty => 1);
     print $mods->as_xml;

     # Deserialize
     my $mods = MODS::Record->from_xml(IO::File->new('mods.xml'));
     my $mods = MODS::Record->from_json(IO::File->new('mods.js'));

DESCRIPTION
    This module provides MODS (http://www.loc.gov/standards/mods/) parsing
    and creation for MODS Schema 3.5.

METHODS
  MODS::Record->new(%attribs)
  MODS::Collection->new(%attribs)
    Create a new MODS record or collection. Optionally attributes can be
    provided as defined by the MODS specification. E.g.

     $mods = MODS::Record->new(ID='123');

  add_xxx()
    Add a new element to the record where 'xxx' is the name of a MODS
    element (e.g. titleInfo, name, genre, etc). This method returns an
    instance of the added MODS element. E.g.

     $titleInfo = $mods->add_titleInfo; # $titleInfo is a 'MODS::Element::TitleInfo'

  add_xxx($text,%attribs)
    Add a new element to the record where 'xxx' is the name of a MODS
    element. Set the text content of the element to $text and optionally
    provide further attributes. This method returns an instance of the added
    MODS element. E.g.

     $mods->add_abstract("My abstract", lang=>'eng');

  add_xxx(sub { })
    Add a new element to the record where 'xxx' is the name of a MODS
    element. The provided coderef gets as input an instance of the added
    MODS element. This method returns an instance of the added MODS element.
    E.g.

     $mods->add_abstract(sub {
            my $o = shift;
            $o->body("My abstract");
            $o->lang("eng");
     })

  add_xxx($obj)
    Add a new element to the record where 'xxx' is the name of a MODS
    element. The $obj is an instance of a MODS::Element::Xxx class (where
    Xxx is the corresponding MODS element). This method returns an instance
    of the added MODS element. E.g.

     $mods->add_abstract(
            MODS::Element::Abstract->new(_body=>'My abstract', lang=>'eng')
     );

  get_xxx()
  get_xxx(%filter)
  get_xxx(sub { })
    Retrieve an element from the record where 'xxx' is the name of a MODS
    element. This methods return in array context all the matching elements
    or the first match in scalar context. Optionally provide a %filter or a
    coderef filter function. E.g.

     @titles = $mods->get_titleInfo();
     $alt    = $mods->get_titleInfo(type=>'alternate');
     $alt    = $mods->get_titleInfo(sub { shift->type eq 'alternate'});

  set_xxxx()
  set_xxx(undef)
  set_xxx($array_ref)
  set_xxx($xxx1,$xxx2,...)
    Set an element of the record to a new value where 'xxx' is the name of a
    MODS element. When no arguments are provided, then this is a null
    operation. When undef als argument is provided, then the element is
    deleted. To overwrite the existing content of the element an ARRAY (ref)
    of MODS::Element::Xxx can be provided (where 'Xxx' is the corresponding
    MODS element). E.g.

     # Delete all abstracts
     $mods->abstract(undef);

     # Set all abstracts
     $mods->abstract(MODS::Element::Abstract->new(), MODS::Element::Abstract->new(), ...);
     $mods->abstract([ MODS::Element::Abstract->new(), MODS::Element::Abstract->new(), ... ]);

  as_xml()
  as_xml(xml_prolog=>1)
    Return the record as XML.

  from_xml($string)
  from_xml(IO::Handle)
    Parse an XML string or IO::Handle into a MODS::Record.

  as_json()
  as_json(pretty=>1)
    Return the record as JSON string.

  from_json($string)
  from_json(IO::Handle)
    Parse and JSON string or JSON::Handle into a MODS::Record.

SEE ALSO
    *   Library Of Congress MODS pages (http://www.loc.gov/standards/mods/)

DESIGN NOTES
    *   I'm not a MODS expert

    *   I needed a MODS module to parse and create MODS records for our
        institutional repository

    *   This module is not created for speed

    *   This module doesn't have any notion of ordering of MODS elements
        themselves (e.g. first 'titleInfo', then 'name'). But each
        sub-element keeps its original order (e.g. each 'title' in
        'titleInfo').

AUTHORS
    *   Patrick Hochstenbach <Patrick . Hochstenbach at UGent . be>

