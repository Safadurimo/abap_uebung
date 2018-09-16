
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'STATUS_100'.
* SET TITLEBAR 'xxx'.
ENDMODULE.


MODULE status_0200 OUTPUT.
 zol_dypro_logic=>get_instance( )->pbo_200( CHANGING kunde_dynpro = zol_kunde_dynpro ).

ENDMODULE.
