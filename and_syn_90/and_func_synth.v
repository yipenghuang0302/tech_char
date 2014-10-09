
module and_func ( a, b, y );
  input a, b;
  output y;


  AND2X1 U2 ( .IN1(b), .IN2(a), .Q(y) );
endmodule

