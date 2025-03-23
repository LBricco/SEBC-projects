`timescale 1ns/1ps
module final_tb_pa;
import UPF::*;

localparam int unsigned NBITS = 8;

logic [NBITS-1 : 0] A_tb;
logic [NBITS-1 : 0] B_tb;
logic [2*NBITS-1 : 0] out_tb;
logic clk;
logic rst_n;
logic op_code_tb;
logic sleep;
bit status0, status1, status2, status3, status4, status5;

dummyALU UUT( 
    .clk(clk),
    .rst_n(rst_n),
    .O(out_tb),
    .B(B_tb),
    .A(A_tb),
    .go_sleep(sleep),
    .OP_CODE(op_code_tb)
);

always@(posedge clk) begin
	if(rst_n != 1'b0 && sleep != 1'b0) begin
	assign_inputs(A_tb, B_tb, op_code_tb);
        #10 compute_correct_result(A_tb, B_tb, op_code_tb, out_tb);  
	end
end 

always #2 clk = ~clk;

initial begin
    rst_n = 0;
    clk = 1;
    A_tb = 8'b00000000;
    B_tb = 8'b00000000;
    op_code_tb = 1'b0;

    // PA Initializations
    status0=supply_on("UUT/VBACK", 1.2);
    status1=supply_on("UUT/VSS", 0.0);
    status2=supply_on("UUT/VDDH", 1.2);
    status3=supply_on("UUT/VDDL", 0.8);

    sleep = 1'b1;
    #10 rst_n = 1; 
    #1000;
    status0=supply_on("UUT/VBACK", 1.2);
    status1=supply_on("UUT/VSS", 0.0);
    status2=supply_on("UUT/VDDH", 0.8);
    status3=supply_on("UUT/VDDL", 0.75);
    #1000
    sleep = 1'b0;
    #4
    status4=supply_off("UUT/VDDL");
    status5=supply_off("UUT/VDDH");
    #200;
    status2=supply_on("UUT/VDDH", 0.8);
    status3=supply_on("UUT/VDDL", 0.75);
    #4
    sleep = 1'b1;
end

task assign_inputs;
    output [NBITS-1 : 0] A, B;
    output op_code;
    
    begin
    A = $urandom_range(0, 100);
    B = $urandom_range(0, 100);
    op_code = $urandom_range(0, 1);
    end

endtask

task compute_correct_result;
    input [NBITS-1 : 0] A, B;
    input op_code;
    input [2*NBITS-1 : 0] res;
    int correct_res;

    begin
    
        $write("[%0t] %d ", $time, A);
    
        if(op_code == 1) begin
            $write("+ %d = %d\n", B, res); 
            correct_res = A + B;    
        end else begin
            $write("* %d = %d\n", B, res); 
            correct_res = A * B;
        end
    
    if(correct_res != res) begin
            $display("Incorrect result! Correct result is %d", correct_res);
    end
    end

endtask

endmodule
