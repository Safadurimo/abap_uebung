CLASS zol_dypro_logic DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.
    CLASS-METHODS get_instance
      RETURNING VALUE(r_instance) TYPE REF TO zol_dypro_logic.
    METHODS: pai_100
      IMPORTING ok_code  TYPE syst_ucomm
                customer TYPE demo_cr_customrs,
      pai_200
        IMPORTING
          ok_code      TYPE syst_ucomm
        CHANGING
          kunde_dynpro TYPE zol_kunde_dynpro,
      pbo_200
        CHANGING
          kunde_dynpro TYPE zol_kunde_dynpro.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: modus TYPE int4, " 1 - Anzeige 2 - Aendern 3 -Anlegen
          kunde TYPE REF TO zol_kunde.
    METHODS map_kunde_to_dypro_fields
      CHANGING kunde_dynpro TYPE zol_kunde_dynpro.
    CLASS-DATA instance TYPE REF TO zol_dypro_logic.
ENDCLASS.



CLASS zol_dypro_logic IMPLEMENTATION.
  METHOD get_instance.
    IF instance IS NOT BOUND.
      CREATE OBJECT instance.
    ENDIF.
    r_instance = instance.
  ENDMETHOD.

  METHOD pai_100.

    CASE ok_code.
      WHEN 'ANLE'.
        CLEAR kunde.
        modus = 3.
        LEAVE TO SCREEN 200.
      WHEN 'ANZE'.
        DATA(geladener_kunde) = zol_kunde_db_access=>lade_kunde(  EXPORTING id = customer-id ).
        IF geladener_kunde IS INITIAL.
          MESSAGE 'Kunde nicht vorhanden' TYPE 'I'.
          RETURN.
        ENDIF.
        kunde = geladener_kunde.
        modus = 1.
        LEAVE TO SCREEN 200.
      WHEN 'AEND'.
      WHEN OTHERS.
    ENDCASE.


  ENDMETHOD.

  METHOD pbo_200.
    CASE modus.
      WHEN 1.
        SET TITLEBAR 'STATUS_200_ANZEIGEN' OF PROGRAM 'SAPLZOL_GUI_CARS'.
        SET PF-STATUS 'STATUS_200_ANSEHEN' OF PROGRAM 'SAPLZOL_GUI_CARS'.
        DATA(geladener_kunde) = zol_kunde_db_access=>lade_kunde(  EXPORTING id = kunde->id ).
        LOOP AT SCREEN INTO DATA(screen_wa).
          screen_wa-input = '0'.
          MODIFY screen FROM screen_wa.
        ENDLOOP.

        map_kunde_to_dypro_fields( CHANGING kunde_dynpro = kunde_dynpro  ).

      WHEN 2.
        SET TITLEBAR 'STATUS_200_AENDERN' OF PROGRAM 'SAPLZOL_GUI_CARS'.
        SET PF-STATUS 'STATUS_200_AENDERN' OF PROGRAM 'SAPLZOL_GUI_CARS'.
      WHEN 3.
        SET TITLEBAR 'STATUS_200_ANLEGEN' OF PROGRAM 'SAPLZOL_GUI_CARS'.
        SET PF-STATUS 'STATUS_200_ANLEGEN' OF PROGRAM 'SAPLZOL_GUI_CARS'.
    ENDCASE.

  ENDMETHOD.

  METHOD pai_200.

    if modus = 2.
        kunde->set_name( IMPORTING name = kunde_dynpro-name ).
    endif.

    CASE ok_code.
      WHEN 'SAVE'.
        IF modus = 3.
          kunde = zol_kunde=>create_new_kunde( EXPORTING name = 'Hans' ).
          zol_kunde_db_access=>speicher_kunde( CHANGING kunde =  kunde ).
        ELSE.
          zol_kunde_db_access=>speicher_kunde( CHANGING kunde =  kunde ).
        ENDIF.
        modus = 1.
      WHEN 'CHANGE'.
        modus = 2.
      WHEN 'DISPLAY'.
        modus = 1.
      WHEN OTHERS.

    ENDCASE.

  ENDMETHOD.


  METHOD map_kunde_to_dypro_fields.
    kunde_dynpro-id = kunde->id.
    kunde_dynpro-anrede = kunde->get_anrede( ).
    kunde_dynpro-name = kunde->name.
    kunde_dynpro-max_geburtstag = kunde->max_geburtstag.
    kunde_dynpro-min_geburstag = kunde->min_geburtstag.

  ENDMETHOD.

ENDCLASS.
