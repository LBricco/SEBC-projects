`timescale 1ns/1ps
module final_tb_pa;
import UPF::*;

localparam int unsigned NBITS = 8;

logic clk;
logic rst_n;
logic [NBITS-1 : 0] A_tb;
logic [NBITS-1 : 0] B_tb;
logic [2*NBITS-1 : 0] out_tb;
logic [NBITS-1 : 0] PROG_tb;
logic [1 : 0] op_code_tb;
logic [1 : 0] prog_logic_tb;
logic [1 : 0]sleep;
bit status0, status1, status2, status3, status4, status5;

dummyALU UUT( 
    .clk(clk),
    .rst_n(rst_n),
    .O(out_tb),
    .B(B_tb),
    .A(A_tb),
    .PROG(PROG_tb),
    .go_sleep(sleep),
    .OP_CODE(op_code_tb),
    .prog_logic(prog_logic_tb)
);


always@(posedge clk) begin
	if(rst_n != 1'b0 && sleep != 2'b00) begin
	assign_inputs(A_tb, B_tb, op_code_tb);
        #10 compute_correct_result(A_tb, B_tb, op_code_tb, out_tb, PROG_tb, prog_logic_tb);  
	end
end 


always #2 clk = ~clk;

initial begin
    rst_n = 0;
    clk = 1;
    A_tb = 8'b00000000;
    B_tb = 8'b00000000;
    op_code_tb = 2'b00;
    PROG_tb = 8'b10101010;
    prog_logic_tb = 2'b00;

    // PA Initializations
    status0=supply_on("UUT/VBACK", 1.2);
    status1=supply_on("UUT/VSS", 0.0);

    status2=supply_on("UUT/VDDM", 0.8);
    status3=supply_on("UUT/VDDA", 1.2);
    status4=supply_on("UUT/VDDL", 0.8);
    status5=supply_on("UUT/VDDLU", 1.2);

    sleep = 2'b11; //full power
    #12 rst_n = 1; 
    #1000;
    status2=supply_on("UUT/VDDM", 0.8);
    status3=supply_on("UUT/VDDA", 1.2);
    status4=supply_on("UUT/VDDL", 0.75);
    status5=supply_on("UUT/VDDLU", 0.75);
    #1000;
    
    sleep = 2'b10; //normal
    #4;
    status2=supply_off("UUT/VDDM");
    #1000;
    status3=supply_on("UUT/VDDA", 0.75);
    status4=supply_on("UUT/VDDL", 0.75);
    status5=supply_on("UUT/VDDLU", 0.75);
    #1000;

    sleep = 2'b01; //low power
    #4;
    status4=supply_off("UUT/VDDL");
    status5=supply_off("UUT/VDDLU");
    #1000;
    status3=supply_on("UUT/VDDA", 0.75);
    #1000;

    sleep = 2'b00; //sleep
    #4;
    status3=supply_off("UUT/VDDA");
    #1000;

    status2=supply_on("UUT/VDDM", 0.8);
    status3=supply_on("UUT/VDDA", 1.2);
    status4=supply_on("UUT/VDDL", 0.8);
    status5=supply_on("UUT/VDDLU", 0.75);
    #4;
    sleep = 2'b11; //full power
end

task assign_inputs;
    output [NBITS-1 : 0] A, B;
    output [1:0] op_code;
    
    begin
    A = $urandom_range(0, 100);
    B = $urandom_range(0, 100);
    op_code = $urandom_range(0, 3);
    end

endtask

task compute_correct_result;
    input [NBITS-1 : 0] A, B;
    input [1 : 0] op_code;
    input [2*NBITS-1 : 0] res;
    input [NBITS-1 : 0] PROG;
    input [1 : 0] prog_logic;
    int correct_res;
    int index_of_LUT;


    begin
        
        index_of_LUT = A[2:0];
        $write("[%0t] ", $time);
    
        if(op_code == 0) begin
            $write("%d + %d = %d\n", A, B, res); 
            correct_res = A + B;    
        end else if(op_code == 1) begin
            $write("%d * %d = %d\n", A, B, res); 
            correct_res = A * B;
        end else if(op_code == 2) begin
            if(prog_logic == 0) begin
                $write("%d AND %d = %d\n", A, B, res); 
                correct_res = A & B;
            end else if (prog_logic == 1) begin
                $write("%d OR %d = %d\n", A, B, res); 
                correct_res = A | B;
            end else if (prog_logic == 2) begin
                $write("%d XOR %d = %d\n", A, B, res); 
                correct_res = A ^ B;
            end
        end else begin
            $write("%b at %d = %d\n", PROG, index_of_LUT, res); 
            correct_res = PROG[index_of_LUT];
        end
    
    if(correct_res != res) begin
            $display("Incorrect result! Correct result is %d", correct_res);
    end
    end

endtask

endmodule
