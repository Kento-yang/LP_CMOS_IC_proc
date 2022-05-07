`timescale 1ns/1ps

module EvtReg #(
    parameter width = 8
    )(
    input rst,
    input [width-1:0] data_in,
    input Rin, 
    input Aout, 

    output [width-1:0] data_out,
    output Ain, 
    output Rout
    );

    wire Capture;

    MullC i_MullC (.Out(Capture), .Ain(Rin), .Bin(~Aout), .Rst(rst));



    EvtLch #(width) i_EvtLch (	
        .data_out(data_out), 
		.data_in(data_in), 
		.En(Capture),
		.rst(rst)
	);    

    assign Rout = Capture;
    assign #1 Ain = Capture;

endmodule
