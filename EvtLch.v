`timescale 1ns/1ps

module EvtLch #(
    parameter width = 8
    )(
    input rst,
    input [width-1:0] data_in,
    input En,
    
    output reg [width-1:0] data_out
    );


always @(*) begin
    if(rst) begin
        data_out = 0;
    end else if(En) begin
        data_out = data_in;
    end
end


endmodule
