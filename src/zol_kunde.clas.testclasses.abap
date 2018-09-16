*"* use this source file for your ABAP unit test classes
CLASS ltcl_kunde DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      anrede_anna FOR TESTING RAISING cx_static_check,
      anrede_peter FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_kunde IMPLEMENTATION.

  METHOD anrede_anna.

    DATA(kunde) = zol_kunde=>create_new_kunde( 'Anna').

    DATA(anrede) = kunde->get_anrede( ).

    cl_abap_unit_assert=>assert_equals(
        msg = 'Falsche Anrede für Ana'
        exp = 'Frau'
        act = anrede ).

  ENDMETHOD.

  METHOD anrede_peter.
    DATA(kunde) = zol_kunde=>create_new_kunde( 'Peter').

    DATA(anrede) = kunde->get_anrede( ).

    cl_abap_unit_assert=>assert_equals(
        msg = 'Falsche Anrede für Peter'
        exp = 'Herr'
        act = anrede ).
  ENDMETHOD.

ENDCLASS.
