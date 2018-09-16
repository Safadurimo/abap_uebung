*"* use this source file for your ABAP unit test classes
CLASS ltcl_kunde_db DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      laden FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_kunde_db IMPLEMENTATION.



  METHOD laden.

    " DB-Tabellen auf bauen
    DATA: kunde_z   TYPE zol_kun,
          kunde_demo TYPE demo_cr_customrs.

    kunde_z = value #(   id  = 1
            geschlecht = abap_true
            min_geb  = '20100101'
            max_geb  = '20100101'
     ).

     modify zol_kun from kunde_z.

     kunde_demo = value #(
       id = 1
       name = 'Hans'
     ).

     modify demo_cr_customrs from kunde_demo.

     DATA(kunde) = zol_kunde_db_access=>lade_kunde(  id = 1 ).

     cl_abap_unit_assert=>assert_equals( msg = 'msg' exp = 1 act = kunde->id ).
     cl_abap_unit_assert=>assert_equals( msg = 'msg' exp = 'Hans' act = kunde->name ).
     cl_abap_unit_assert=>assert_equals( msg = 'msg' exp = abap_true act = kunde->geschlecht ).
     cl_abap_unit_assert=>assert_equals( msg = 'msg' exp = '20100101'  act = kunde->max_geburtstag ).
     cl_abap_unit_assert=>assert_equals( msg = 'msg' exp = '20100101'  act = kunde->min_geburtstag ).

  ENDMETHOD.



ENDCLASS.
