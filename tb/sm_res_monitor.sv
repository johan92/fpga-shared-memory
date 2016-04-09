class sm_res_monitor;
  
  sm_res_if             __if;
  mailbox #( sm_res_t ) mbx;

  function new( input virtual sm_res_if      _if, 
                      mailbox #( sm_res_t )  _mbx 
              );

    this.__if = _if;
    this.mbx  = _mbx; 

    // FIXME: do it random
    this.__if.ready <= 1'b1;
  endfunction
  
  task run( );
    fork
      thread_receive( );
    join
  endtask

  task thread_receive( );
    
    sm_res_t tmp;
    
    forever
      begin
        receive( tmp );
        mbx.put( tmp );
      end

  endtask

  task receive( output sm_res_t _res );
    _res = 'x;

    forever
      begin
        @__if.cb;

        if( __if.valid && __if.ready )
          begin
            _res = __if.data;
            break;
          end
      end

  endtask

endclass
