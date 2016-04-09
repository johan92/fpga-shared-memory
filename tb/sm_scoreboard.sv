class sm_scoreboard;
  
  sm_ref_model model;

  mailbox #( pkt_t )    pkt_in_mbx; 
  mailbox #( pkt_t )    pkt_out_mbx;

  mailbox #( sm_res_t ) res_mbx;
  mailbox #( sm_cmd_t ) cmd_mbx;
  
  task new( );
    this.model = new( );

  endtask

  task run( );
    fork
      thread_write_side( );
      thread_read_side( );
    join
  endtask

  task thread_write_side( );
    pkt_t    pkt;
    sm_res_t res;

    forever
      begin
        pkt_in_mbx.get( pkt );
        res_mbx.get( res );

        model.write_pkt( pkt, res );
      end

  endtask

  task thread_read_side( );
    pkt_t     pkt;
    sm_cmd_t  cmd;

    forever
      begin

        cmd_mbx.get( cmd );

        if( cmd.code == sm::FREE )
          begin
            // will be no output packet,
            // execute right now
            model.do_free_cmd( cmd );
          end
        else
          begin
            // waiting for output packet
            pkt_out_mbx.get( pkt );

            model.do_read_cmd( pkt, cmd );
          end

      end

  endtask

endclass
