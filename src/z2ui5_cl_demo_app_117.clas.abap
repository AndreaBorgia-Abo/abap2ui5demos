CLASS z2ui5_cl_demo_app_117 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_117 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


* Abschnitt 1
    out->begin_section( '1. Überschrift' ).
     out->begin_section( '1.1 Überschrift' ).
* Text
     out->write_text( 'Text 1.1' ).
     out->write( 'Text 1.1 non proportional' ).
     out->end_section( ).
     out->end_section( ).
* Abschnitt 2
     out->begin_section( '2. Überschrift' ).
     out->begin_section( '2.1 Überschrift' ).
* Text
     out->write_text( 'Text 2.1' ).
     out->write( 'Text 2.1 non proportional' ).
     out->end_section( ).
     out->end_section( ).

    TYPES: BEGIN OF ty_struct,
             f1 TYPE string,
             f2 TYPE i,
           END OF ty_struct.

    TYPES: ty_it_tab TYPE STANDARD TABLE OF ty_struct WITH DEFAULT KEY.

    DATA(lv_struct) = VALUE ty_struct( f1 = 'Field1' f2 = 1 ).
    DATA(it_tab) = VALUE ty_it_tab( ( f1 = 'T1' f2 = 1 )
                                    ( f1 = 'T2' f2 = 2 )
                                    ( f1 = 'T3' f2 = 3 ) ).

     out->write_data( value = -100         name = 'Zahl' ).
     out->write_data( value = 'ein String' name = 'Text' ).
     out->write_data( value = lv_struct    name = 'Struct' ).
     out->write_data( value = it_tab       name = 'Tab' ).

     out->write_text( 'Oben' ).
     out->line( ).
     out->write_text( 'Unten' ).

* alles anzeigen
    SELECT * FROM t100 INTO TABLE @DATA(it_mara) up to 20 rows.

     out->write_data( it_mara ).

     out->write_text( |blah blah blah \n| &&
                                |blah blah blah| ).

    TYPES:
      BEGIN OF spfli_line,
        carrid   TYPE spfli-carrid,
        connid   TYPE spfli-connid,
        cityfrom TYPE spfli-cityfrom,
        cityto   TYPE spfli-cityto,
      END OF spfli_line,
      spfli_tab TYPE HASHED TABLE OF spfli_line
                     WITH UNIQUE KEY carrid connid,
      BEGIN OF struct,
        carrname TYPE scarr-carrname,
        spfli    TYPE REF TO spfli_tab,
      END OF struct.

    SELECT s~carrname, p~carrid, p~connid, p~cityfrom, p~cityto
           FROM scarr AS s
             INNER JOIN spfli AS p
               ON s~carrid = p~carrid
           ORDER BY s~carrname
           INTO TABLE @DATA(itab).

     out->write_data( itab ).

    DATA itab2 TYPE TABLE OF i WITH EMPTY KEY.

    itab2 = VALUE #( ( 1 ) ( 2 ) ( 3 ) ).

    DATA(json_writer) = cl_sxml_string_writer=>create(
                          type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE itab = itab2
                           RESULT XML json_writer.
    DATA(json) = json_writer->get_output( ).



  ENDMETHOD.
ENDCLASS.
