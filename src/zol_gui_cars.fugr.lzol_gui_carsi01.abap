MODULE on_exit INPUT.
  LEAVE TO SCREEN 0.
ENDMODULE.


MODULE user_command_0100 INPUT.

    zol_dypro_logic=>get_instance( )->pai_100(
        exporting   customer = DEMO_CR_CUSTOMRS
                    ok_code = gv_ok_code ).


ENDMODULE.


MODULE user_command_0200 INPUT.
   zol_dypro_logic=>get_instance( )->pai_200(
   exporting  ok_code = gv_ok_code
   changing   kunde_dynpro  = ZOL_KUNDE_DYNPRO
    ).
ENDMODULE.
