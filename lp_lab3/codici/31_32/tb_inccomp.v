`timescale 1ns/1ps
module tbinccomp();
 
  wire [7:0] C;
  reg ck, rst, INCA, INCB;
 
  inccomp DUT ( // dichiarazione DUT (analogo a dichiarazione component in VHDL)
    .C(C),
	  .ck(ck),
    .rst(rst),
    .INCA(INCA),
	  .INCB(INCB)
  );
 
  initial 
  begin
    rst = 1; INCA = 0; INCB = 0; 
    #2; rst = 1;	// at time 0.1 reset = 1
    #5; rst = 0;
    #5; INCA = 1;
    #16; INCB = 1;
	  #22; INCA = 0;
  end

  always
  begin
 	ck = 1'b1;
    #2.5;
	ck = 1'b0;
    #2.5;
  end
 
endmodule