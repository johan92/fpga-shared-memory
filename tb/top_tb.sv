import sm::*;
import sm_tb::*;

module top_tb;

localparam DATA_W = 32;

bit clk;
bit rst;

always #5ns clk = !clk;

initial
  begin
    rst = 1'b1;
    @( posedge clk );
    @( posedge clk );
    @( negedge clk );
    rst <= 1'b0;
  end

sm_res_if sm_res_if( .clk( clk ) );
sm_cmd_if sm_cmd_if( .clk( clk ) );

sm_top #( 
  .AST_DATA_W                             ( DATA_W            )
) dut (
  
  .clk_i                                  ( clk               ),
  .rst_i                                  ( rst               ),
    
  // WRITE SIDE
  // input packet
  .ast_snk_ready_o                        ( ast_snk_ready_o   ),
  .ast_snk_valid_i                        ( ast_snk_valid_i   ),
  .ast_snk_data_i                         ( ast_snk_data_i    ),
  .ast_snk_sop_i                          ( ast_snk_sop_i     ),
  .ast_snk_eop_i                          ( ast_snk_eop_i     ),
  .ast_snk_empty_i                        ( ast_snk_empty_i   ),
   
  // output result for each packet
  .sm_res_data_o                          ( sm_res_if.cb.data  ),
  .sm_res_valid_o                         ( sm_res_if.cb.valid ),
  .sm_res_ready_i                         ( sm_res_if.cb.ready ),

  // READ SIDE
  // output packet
  .ast_src_ready_i                        ( ast_src_ready_i    ),
  .ast_src_valid_o                        ( ast_src_valid_o    ),
  .ast_src_data_o                         ( ast_src_data_o     ),
  .ast_src_sop_o                          ( ast_src_sop_o      ),
  .ast_src_eop_o                          ( ast_src_eop_o      ),
  .ast_src_empty_o                        ( ast_src_empty_o    ),

   // input command
  .sm_cmd_data_i                          ( sm_cmd_if.cb.data  ),
  .sm_cmd_valid_i                         ( sm_cmd_if.cb.valid ),
  .sm_cmd_ready_o                         ( sm_cmd_if.cb.ready )

);


endmodule
