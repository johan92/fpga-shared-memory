class sm_ref_model;
  
  pkt_t arr[ sm_ptr_t ];

  semaphore sem;

  function new( );
    // TODO: clean arr(?)

    this.sem = new( 1 );
  endfunction 

  function void write_pkt( input pkt_t _pkt, sm_res_t _dut_res );
    sem.get( 1 );

    case( _dut_res.code )
      WR_OK:
        begin
          if( arr.exists( _dut_res.ptr ) )
            begin
              $error( "DUT write packet to ptr = 0x%x, that has packet!", _dut_res.ptr );
            end
          else
            begin
              // copy packet to array
              arr[ _dut_res.ptr ] = _pkt;
            end
        end

      WR_ERR_NO_SPACE:
        begin
          // TODO:
          // check if packet size is really can't fit to array
        end

      default:
        begin
          $error( "code = [%s] not supported!", _dut_res.code );
        end

    endcase
    
    sem.put( 1 );
  endfunction

  function void do_read_cmd( input pkt _dut_pkt, sm_cmd_t _cmd );

    if( _cmd.code != sm::READ )
      begin
        $error( "Expected here cmds only with code = %s, got code = %s", sm::READ, _cmd.code );
        return;
      end

    sem.get( 1 );

    if( arr.exists[ _cmd.ptr ] )
      begin
        // FIXME: write real function
        // pkt_compare( arr[ _cmd.ptr ], _dut_pkt );
      end
    else
      begin
        $error( "Trying to read packet from empty ptr = 0x%x", _cmd.ptr );
      end

    sem.put( 1 );

  endfunction

  function void do_free_cmd( input sm_cmd_t _cmd );

    if( _cmd.code != sm::FREE )
      begin
        $error( "Expected here cmds only with code = %s, got code = %s", sm::FREE, _cmd.code );
        return;
      end
    
    sem.get( 1 );

    if( arr.exists[ _cmd.ptr ] )
      begin
        arr.delete( _cmd.ptr );
      end
    else
      begin
        $error( "Trying to free empty ptr = 0x%x", _cmd.ptr );
      end

    sem.put( 1 );

  endfunction

endclass
