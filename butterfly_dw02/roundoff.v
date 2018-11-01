module roundoff(z,a);
parameter bits=30;
parameter int_bits=bits*2;
input  signed [int_bits-1:0] a;
output signed [bits-1:0] z;
assign z=a[int_bits-1]?a[49:20]:(a[49:20]+a[19]);
endmodule
