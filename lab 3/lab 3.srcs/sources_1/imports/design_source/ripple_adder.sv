module ripple_adder (
	input  logic  [15:0] a, 
    input  logic  [15:0] b,
	input  logic         cin,
	
	output logic  [15:0] s,
	output logic         cout
);

	/* TODO
		*
		* Insert code here to implement a ripple adder.
		* Your code should be completly combinational (don't use always_ff or always_latch).
		* Feel free to create sub-modules or other files. */
		
		module full_adder (input logic x, y, z,
            output logic s, c );
                assign s = x^y^z;
                assign c = (x&y)|(y&z)|(x&z);
        endmodule
        module ADDER4 (input logic [3:0] A, B,
            input logic c_in,
            output logic [3:0] S,
            output logic c_out);
                logic c1, c2, c3; //internal carry adder bits 
                full_adder FA0(.x(A[0]), .y(B[0]), .z(c_in), .s(S[0]), .c(c1));
                full_adder FA1(.x(A[1]), .y(B[1]), .z(c1), .s(S[1]), .c(c2));
                full_adder FA2(.x(A[2]), .y(B[2]), .z(c2), .s(S[2]), .c(c3));
                full_adder FA3(.x(A[3]), .y(B[3]), .z(c3), .s(S[3]), .c(c_out));
        endmodule
        
        logic c4, c5, c6;
        ADDER4 FA4(.A(a[3:0]), .B(b[3:0]), .c_in(cin), .S(s[3:0]), .c_out(c4));
        ADDER4 FA5(.A(a[7:4]), .B(b[7:4]), .c_in(c4), .S(s[7:4]), .c_out(c5));
        ADDER4 FA6(.A(a[11:8]), .B(b[11:8]), .c_in(c5), .S(s[11:8]), .c_out(c6));
        ADDER4 FA7(.A(a[15:12]), .B(b[15:12]),  .c_in(c6), .S(s[15:12]), .c_out(cout));
endmodule