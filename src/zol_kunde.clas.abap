class ZOL_KUNDE definition
  public
  final
  create private .

public section.

  data ID type DEMO_CR_CUSTOMER_ID .
  data NAME type DEMO_CR_CUSTOMER_NAME read-only .
  data GESCHLECHT type ABAP_BOOL read-only .
  data MIN_GEBURTSTAG type DATS read-only .
  data MAX_GEBURTSTAG type DATS read-only .

  methods SET_ALTER
    exporting
      !ALTER type INT4 .
  methods SET_NAME
    exporting
      !NAME type DEMO_CR_CUSTOMER_NAME .
  methods GET_ANREDE
    returning
      value(ANREDE) type CHAR20 .
  class-methods CREATE_NEW_KUNDE
    importing
      !NAME type DEMO_CR_CUSTOMER_NAME
    returning
      value(KUNDE) type ref to ZOL_KUNDE .
  class-methods CREATE_KUNDE_FROM_DB
    importing
      !IS_CUSTOMER type DEMO_CR_CUSTOMRS
      !IS_KUNDE type ZOL_KUN
    returning
      value(KUNDE) type ref to ZOL_KUNDE .
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS ZOL_KUNDE IMPLEMENTATION.


  METHOD create_kunde_from_db.
    CREATE OBJECT kunde.
    kunde->id = is_customer-id.
    kunde->name = is_customer-name.

  ENDMETHOD.


  METHOD create_new_kunde.
    CREATE OBJECT kunde.
    kunde->name = name.

  ENDMETHOD.


  METHOD get_anrede.
    anrede = 'ey' && name .
  ENDMETHOD.


  METHOD set_alter.

  ENDMETHOD.


  METHOD set_name.
    name = name.
  ENDMETHOD.
ENDCLASS.
