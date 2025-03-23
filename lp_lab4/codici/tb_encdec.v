`timescale 1ns/1ps
//`define ADDRESS	// uncomment for address analysis
`define DATA	// uncomment for data analysis
module testbench();

	// inputs of the DUT.
	reg [7:0] Ain;
	reg ck, rst;
	
	// outputs of the DUT.
	//busnormal
	wire [7:0] ABUSNORM, COUNTBUSNORM, CBUSNORM;

	//businvert
	wire [8:0] COUNTBUSINVBEH; 
	wire [7:0] CBUSINVBEH;

	//transbased
	wire [7:0] COUNTTRANSBASED, CTRANSBASED;
	
	//grayencoder
	wire [7:0] COUNTGRAYENCODER, CGRAYENCODER;

	//toencoder
	wire [8:0] COUNTT0ENCODER; 
	wire [7:0] CT0ENCODER;

	// just for power report.
	wire CK, RST;
	wire [7:0] A;
	
	// file descriptor
	integer infile, count;
	
	// store each line of file
	reg [7:0] line;
	
	parameter CLOCK_PERIOD = 10;
	parameter DELAY = 0.1;

	// component busnormal
	busnormal UBUSNORM (
		.ck(ck),
		.rst(rst),
		.A(ABUSNORM),
		.B(COUNTBUSNORM),
		.C(CBUSNORM)
	);


	// component businvbeh
	businvbeh UBUSINV (	
		.ck(ck),
		.rst(rst),
		.A(ABUSNORM),
		.B(COUNTBUSINVBEH),
		.C(CBUSINVBEH)
	);

	// component transbases
	transbased UBUSTRAN (	
		.ck(ck),
		.rst(rst),
		.A(ABUSNORM),
		.B(COUNTTRANSBASED),
		.C(CTRANSBASED)
	);

	// component grayencoder
	grayencoder UBUSGRAY (	
		.ck(ck),
		.rst(rst),
		.A(ABUSNORM),
		.B(COUNTGRAYENCODER),
		.C(CGRAYENCODER)
	);

	// component t0encdec
	t0encoder UBUST0 (
		.ck(ck),
		.rst(rst),
		.A(ABUSNORM),
		.B(COUNTT0ENCODER),
		.C(CT0ENCODER)
	);
	
	// Executed only once at the beginning of the simulation
	initial
	begin
		ck = 1'b0;
		rst = 1'b0;
		Ain = 0;
		#0.1;
		rst = 1'b1;
		#0.2;
		rst = 1'b0;
	end
	
	initial
	begin
		infile = $fopen("rndin.txt", "r");
		if (infile == 0) begin
			$display("infile descriptor is NULL");
			$finish;
		end
	end
	
	// clock generation
	always
	begin
		#(CLOCK_PERIOD/2.0)ck <= ~ck;
	end
	
`ifdef ADDRESS
    // add like inputs
	always @(posedge ck or posedge rst)
	begin
		if (rst) begin
			Ain <= 0;
		end
		else begin
			if(!$feof(infile)) begin
				count = $fscanf(infile, "%b\n", line);
				if(A == 63) begin
					#DELAY Ain[7:6] <= line[7:6];
					#DELAY Ain[5:0] <= 6'b0;
				end
				else begin
					#DELAY Ain <= Ain + 1;
				end
			end
	    end
	end
`endif
	
`ifdef DATA
	// data like inputs
	always @(posedge ck or posedge rst)
	begin
		if (rst) begin
			Ain <= 0;
		end
		else begin
			if(!$feof(infile)) begin
				count = $fscanf(infile, "%b\n", line);
				// data with almost equal 1 and 0 probability
				#DELAY Ain <= line;
			end
		end
	end
`endif
	
	assign ABUSNORM = Ain;
	assign A = Ain;
	assign CK = ck;
	assign RST = rst;

	        
endmodule
