interface sm_res_if( 
  input clk
);

  sm_res_t          data;
  logic             valid;
  logic             ready;


clocking cb @( posedge clk );
  input  data,
         valid;

  output ready;
endclocking


endinterface
