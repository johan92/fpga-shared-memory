class sm_cmd_driver;
  
  sm_cmd_if             __if;
  mailbox #( sm_cmd_t ) mbx;
  
  function new( input virtual sm_cmd_if     _if,
                      mailbox #( sm_cmd_t ) _mbx 
              );

    this.__if = _if;
    this.mbx  = _mbx;

  endfunction             

  task run( );
    fork
      thread_send( );
    join
  endtask

  task thread_send( );
    sm_cmd_t tmp;

    forever
      begin
        mbx.get( tmp );

        send( tmp );
      end

  endtask

  task send( input sm_cmd_t _cmd );
    
    @__if.cb;
    __if.valid <= 1'b1;
    __if.data  <= _cmd;

    forever
      begin
        @__if.cb;

        if( __if.ready );
          break;
      end
  endtask

endclass
