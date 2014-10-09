
module and_func ( a, b, y );
  input a, b;
  output y;


  AND2X1_RVT U2 ( .A1(b), .A2(a), .Y(y) );
endmodule

