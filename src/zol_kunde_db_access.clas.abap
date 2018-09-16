CLASS zol_kunde_db_access DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  class-METHODS:
    lade_kunde
        importing id type DEMO_CR_CUSTOMER_id
        RETURNING VALUE(kunde) type ref to zol_kunde,
    speicher_kunde
        changing kunde type ref to zol_kunde.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zol_kunde_db_access IMPLEMENTATION.

  METHOD lade_kunde.

    Select single * from DEMO_CR_CUSTOMRS into @DATA(customer).

    if customer is INITIAL.
        return.
    endif.


    kunde = zol_kunde=>create_kunde_from_db(
        EXPORTING is_customer = customer
                   is_kunde = value #( )
    ).

  ENDMETHOD.



  METHOD speicher_kunde.
    DATA: random_int type qfranint,
          customer type demo_cr_customrs.

    if kunde->id is INITIAL.
        call FUNCTION 'QF05_RANDOM_INTEGER'
            importing ran_int = random_int.
            customer-id = random_int.
            kunde->id = customer-id.
    endif.

    customer-name = kunde->name.

    insert demo_cr_customrs from customer.

  ENDMETHOD.

ENDCLASS.
