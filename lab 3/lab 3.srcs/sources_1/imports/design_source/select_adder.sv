module select_adder (
	input  logic  [15:0] a, 
    input  logic  [15:0] b,
	input  logic         cin,
	
	output logic  [15:0] s,
	output logic         cout
);

	/* TODO
		*
		* Insert code here to implement a CSA adder.
		* Your code should be completly combinational (don't use always_ff or always_latch).
		* Feel free to create sub-modules or other files. */
		
		
		module mux( input logic [3:0] a, b,
		            input logic select,
		            output logic [3:0] out);
		            
		  always_comb
		  begin
		  
		      /*
		      if(select == 1'b0) 
		          out = a;
		      else 
		          out = b;
		          
		          */
		          
		          out = select ? b : a;
		  end 
		  
		endmodule
		
		
		
		module Select_full_adder (input logic x, y, z,
            output logic s, c );
                assign s = x^y^z;
                assign c = (x&y)|(y&z)|(x&z);
        endmodule
        
      
        module Select_ADDER4 (input logic [3:0] A, B,
            input logic c_in,
            output logic [3:0] S,
            output logic c_out);
                logic c1, c2, c3; //internal carry adder bits 
                Select_full_adder FA0(.x(A[0]), .y(B[0]), .z(c_in), .s(S[0]), .c(c1));
                Select_full_adder FA1(.x(A[1]), .y(B[1]), .z(c1), .s(S[1]), .c(c2));
                Select_full_adder FA2(.x(A[2]), .y(B[2]), .z(c2), .s(S[2]), .c(c3));
                Select_full_adder FA3(.x(A[3]), .y(B[3]), .z(c3), .s(S[3]), .c(c_out));
        endmodule
        
        logic c4, c5, c6, c8, c12, c90, c91, c92, c93;
        logic [3:0] outty1, outty2, outty3, outty4, outty5, outty6;
       
        //assign s[15:0] = 16'b0000000000000000;
        
        Select_ADDER4 FA4(.A(a[3:0]), .B(b[3:0]), .c_in(cin), .S(s[3:0]), .c_out(c4));
        
        
        
        Select_ADDER4 FA5(.A(a[7:4]), .B(b[7:4]), .c_in(0), .S(outty1), .c_out(c5));
        Select_ADDER4 FA6(.A(a[7:4]), .B(b[7:4]), .c_in(1), .S(outty2), .c_out(c6));
        
        mux FA11(.a(outty1), .b(outty2), .select(c4), .out(s[7:4]));
        assign c8 = c5 ^ (c6 * c4);
        
        
        Select_ADDER4 FA7(.A(a[11:8]), .B(b[11:8]), .c_in(0), .S(outty3), .c_out(c90));
        Select_ADDER4 FA8(.A(a[11:8]), .B(b[11:8]), .c_in(1), .S(outty4), .c_out(c91));
        
        mux FA12(.a(outty3), .b(outty4), .select(c8), .out(s[11:8]));
        assign c12 = c90 ^ (c91 * c8);
        
        Select_ADDER4 FA9(.A(a[15:12]), .B(b[15:12]), .c_in(0), .S(outty5), .c_out(c92));
        Select_ADDER4 FA10(.A(a[15:12]), .B(b[15:12]),  .c_in(1), .S(outty6), .c_out(c93));
        
        mux FA13(.a(outty5), .b(outty6), .select(c12), .out(s[15:12]));
        assign cout = c92 ^ (c93 * c12);
		

endmodule
