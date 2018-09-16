class ZOL_KUNDEN_STARTER definition
  public
  final
  create public .

public section.

  methods START .
protected section.
private section.
ENDCLASS.



CLASS ZOL_KUNDEN_STARTER IMPLEMENTATION.


  METHOD start.
    CALL FUNCTION 'Z_OL_EINSTIEG_KUNDE'.
  ENDMETHOD.
ENDCLASS.
