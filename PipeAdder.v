`timescale 1ns/1ps

module PipeAdder (
    input           rst,
    input    [7:0]  a,
    input    [7:0]  b,
    input    [7:0]  c,

    input           Rin,
    input           Aout,//ack
    
    output          Rout,//req
    output          Ain,

    output   [7:0]  out
    );


wire [7:0] in1_a;
wire [7:0] in1_b;
wire [7:0] out1_a;
wire [7:0] out1_b;

wire Ain1, Rout1, Rin1, Aout1;

wire [7:0] in2_ab;
wire [7:0] in2_c;
wire [7:0] out2_ab;
wire [7:0] out2_c;

wire Ain2, Rout2, Rin2, Aout2;

assign Rin1 = Rin;
assign Aout1 = Ain2;
assign in1_a = a;
assign in1_b = b;
assign in2_c = c;

wire [7:0] in3;
wire [7:0] out3;

wire Ain3, Rout3, Rin3, Aout3;

//========================stage 1==========================
EvtReg #(8) i1_EvtReg_a (
    .rst(rst),
    .data_in(in1_a),
    .Rin(Rin1), 
    .Aout(Aout1), 
    
    .data_out(out1_a),
    .Ain(Ain1), 
    .Rout(Rout1)
    );

EvtReg #(8) i1_EvtReg_b(
    .rst(rst),
    .data_in(in1_b),
    .Rin(Rin1), 
    .Aout(Aout1), 
    
    .data_out(out1_b),
    .Ain(), //no output ack
    .Rout() //no output req
    );

Dly i1_Dly(Rin2, Rout1);


//========================ALU=======================
assign #10 in2_ab  = out1_a + out1_b;

//======================stage 2======================
assign Aout2 = Ain3;
EvtReg #(8) i2_EvtReg_ab(
    .rst(rst),
    .data_in(in2_ab),
    .Rin(Rin2), 
    .Aout(Aout2), 
    
    .data_out(out2_ab),
    .Ain(Ain2), 
    .Rout(Rout2)
    );
    
EvtReg #(8) i2_EvtReg_c (
    .rst(rst),
    .data_in(in2_c),
    .Rin(Rin2), 
    .Aout(Aout2), 
    
    .data_out(out2_c),
    .Ain(), 
    .Rout()
    );
Dly i2_Dly(Rin3, Rout2);

assign #10 in3 = out2_ab + out2_c;
assign Aout3 = Aout;
//======================output==========================
EvtReg #(8) i3_EvtReg(
    .rst(rst),
    .data_in(in3),
    .Rin(Rin3), 
    .Aout(Aout3), 
    
    .data_out(out3),
    .Ain(Ain3), 
    .Rout(Rout3)
    );

assign out = out3;
assign Rout = Rout3;

assign Ain = Ain1;

endmodule
