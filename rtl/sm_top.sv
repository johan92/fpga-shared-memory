import sm_pkg::*;

module sm_top #( 
  parameter AST_DATA_W  = 32,

  // internal parameters...
  parameter AST_EMPTY_W = ( AST_DATA_W / 8 ) - 1
) (
  
  input                      clk_i,
  input                      rst_i,
  
  // WRITE SIDE
  // input packet
  output                     ast_snk_ready_o,
  input                      ast_snk_valid_i,
  input   [AST_DATA_W-1:0]   ast_snk_data_i,
  input                      ast_snk_sop_i,
  input                      ast_snk_eop_i,
  input   [AST_EMPTY_W-1:0]  ast_snk_empty_i,
 
  // output result for each packet
  output  sm_res_t           sm_res_data_o,
  output                     sm_res_valid_o,
  input                      sm_res_ready_i,

  // READ SIDE
  // output packet
  input                      ast_src_ready_i,
  output                     ast_src_valid_o,
  output   [AST_DATA_W-1:0]  ast_src_data_o,
  output                     ast_src_sop_o,
  output                     ast_src_eop_o,
  output   [AST_EMPTY_W-1:0] ast_src_empty_o,

  // input command
  input    sm_cmd_t          sm_cmd_data_i,
  input                      sm_cmd_valid_i,
  output                     sm_cmd_ready_o

);


endmodule
