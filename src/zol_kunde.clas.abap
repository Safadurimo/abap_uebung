CLASS zol_kunde DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.
    DATA: id             TYPE demo_cr_customer_id,
          name           TYPE demo_cr_customer_name READ-ONLY,
          geschlecht     TYPE abap_bool READ-ONLY,
          min_geburtstag TYPE dats READ-ONLY,
          max_geburtstag TYPE dats READ-ONLY.
    METHODS: set_alter
      EXPORTING alter TYPE int4,
      set_name
        EXPORTING name TYPE demo_cr_customer_name,
      get_anrede RETURNING VALUE(anrede) TYPE char20.
    CLASS-METHODS:
      create_new_kunde
        IMPORTING name         TYPE demo_cr_customer_name
        RETURNING VALUE(kunde) TYPE REF TO zol_kunde,
      create_kunde_from_db
        IMPORTING is_customer  TYPE demo_cr_customrs
                  is_kunde     TYPE zol_kun
        RETURNING VALUE(kunde) TYPE REF TO zol_kunde.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zol_kunde IMPLEMENTATION.

  METHOD set_alter.

  ENDMETHOD.

  METHOD set_name.
    name = name.
  ENDMETHOD.

  METHOD get_anrede.
    anrede = 'ey' && name .
  ENDMETHOD.

  METHOD create_new_kunde.
    CREATE OBJECT kunde.
    kunde->name = name.

  ENDMETHOD.

  METHOD create_kunde_from_db.
    CREATE OBJECT kunde.
    kunde->id = is_customer-id.
    kunde->name = is_customer-name.

  ENDMETHOD.

ENDCLASS.
