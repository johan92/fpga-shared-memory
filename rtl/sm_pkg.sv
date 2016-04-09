package sm;
  
  parameter SM_PTR_WIDTH = 8;

  typedef logic [SM_PTR_WIDTH-1:0] sm_ptr_t;

  typedef enum int unsigned {
    WR_OK,
    WR_ERR_NO_SPACE
  } sm_res_code_t;

  typedef struct packed {
    
    sm_res_code_t code;
    sm_ptr_t      ptr;

  } sm_res_t;

  typedef enum int unsigned {
    RD,
    CLEAR
  } sm_cmd_code_t;
  
  typedef struct packed {
    sm_res_code_t code;
    sm_ptr_t      ptr;
  } sm_cmd_t;


endpackage
