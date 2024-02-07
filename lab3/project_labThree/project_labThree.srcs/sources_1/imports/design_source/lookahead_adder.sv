module lookahead_adder (
	input  logic  [15:0] a, 
    input  logic  [15:0] b,
	input  logic         cin,
	
	output logic  [15:0] s,
	output logic         cout
);

	/* TODO
		*
		* Insert code here to implement a CLA adder.
		* Your code should be completly combinational (don't use always_ff or always_latch).
		* Feel free to create sub-modules or other files. */
		
		
		module Look_full_adder (input logic x, y, z,
            output logic s, c );
                assign s = x^y^z;
                assign c = (x&y)|(y&z)|(x&z);
        endmodule
        module Look_ADDER4 (input logic [3:0] A, B,
            input logic c_in,
            output logic [3:0] S,
            output logic c_out);
                logic c0, c1, c2, c3, g0, g1, g2, p0, p1, p2; //internal carry adder bits 
                logic c21, c22, c23; // placeholder dummy variables
                assign c0 = c_in;
                assign c1 = (c_in & p0) ^ g0;
                assign c2 = (c_in & p0 & p1) ^ (g0 * p1) ^ g1;
                assign c3 = (c_in & p0 & p1 & p2) ^ (g0 * p1 & p2) ^ (g1 & p2) ^ g2;
                assign g0 = A[0] & B[0]; 
                assign g1 = A[1] & B[1]; 
                assign g2 = A[2] & B[2]; 
                assign p0 = A[0] ^ B[0]; 
                assign p1 = A[1] ^ B[1]; 
                assign p2 = A[2] ^ B[2]; 
                
                                     
                Look_full_adder FA0(.x(A[0]), .y(B[0]), .z(c0), .s(S[0]), .c(c21));
                Look_full_adder FA1(.x(A[1]), .y(B[1]), .z(c1), .s(S[1]), .c(c22));
                Look_full_adder FA2(.x(A[2]), .y(B[2]), .z(c2), .s(S[2]), .c(c23));
                Look_full_adder FA3(.x(A[3]), .y(B[3]), .z(c3), .s(S[3]), .c(c_out));
        endmodule
        
        logic c4, c8, c12, pg0, pg4, pg8, gg0, gg4, gg8;
        logic c44, c45, c46; // placeholder dummy variables
        
        assign c4 = (cin & pg0) ^ gg0;
        assign c8 = (cin & pg0 & pg4) ^ (gg0 * pg4) ^ gg4;
        assign c12 = (cin & pg0 & pg4 & pg8) ^ (gg0 * pg4 & pg8) ^ (gg4 & pg8) ^ gg8;
        assign pg0 = (a[0] ^ b[0]) & (a[1] ^ b[1]) & (a[2] ^ b[2]) & (a[3] ^ b[3]);
        assign pg4 = (a[4] ^ b[4]) & (a[5] ^ b[5]) & (a[6] ^ b[6]) & (a[7] ^ b[7]);
        assign pg8 = (a[8] ^ b[8]) & (a[9] ^ b[9]) & (a[10] ^ b[10]) & (a[11] ^ b[11]);
        assign gg0 = (a[3] & b[3]) ^ ((a[2] & b[2]) & (a[3] ^ b[3])) ^ ((a[1] & b[1]) & (a[2] ^ b[2]) & (a[3] ^ b[3])) ^ ((a[0] & b[0]) & (a[1] ^ b[1]) & (a[2] ^ b[2]) & (a[3] ^ b[3]));
        assign gg4 = (a[7] & b[7]) ^ ((a[6] & b[6]) & (a[7] ^ b[7])) ^ ((a[5] & b[5]) & (a[6] ^ b[6]) & (a[7] ^ b[7])) ^ ((a[4] & b[4]) & (a[5] ^ b[5]) & (a[6] ^ b[6]) & (a[7] ^ b[7]));
        assign gg8 = (a[11] & b[11]) ^ ((a[10] & b[10]) & (a[11] ^ b[11])) ^ ((a[9] & b[9]) & (a[10] ^ b[10]) & (a[11] ^ b[11])) ^ ((a[8] & b[8]) & (a[9] ^ b[9]) & (a[10] ^ b[10]) & (a[11] ^ b[11]));
        
        Look_ADDER4 FA4(.A(a[3:0]), .B(b[3:0]), .c_in(cin), .S(s[3:0]), .c_out(c44));
        Look_ADDER4 FA5(.A(a[7:4]), .B(b[7:4]), .c_in(c4), .S(s[7:4]), .c_out(c45));
        Look_ADDER4 FA6(.A(a[11:8]), .B(b[11:8]), .c_in(c8), .S(s[11:8]), .c_out(c46));
        Look_ADDER4 FA7(.A(a[15:12]), .B(b[15:12]),  .c_in(c12), .S(s[15:12]), .c_out(cout));


endmodule
