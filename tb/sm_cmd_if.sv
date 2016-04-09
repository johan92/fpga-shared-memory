interface sm_cmd_if( 
  input clk
);

  sm_cmd_t          data;
  logic             valid;
  logic             ready;


clocking cb @( posedge clk );
  output data,
         valid;

  input  ready;
endclocking


endinterface
