`timescale 1ns/1ps


module Dly #(
    parameter dlynum = 10
    )
    (
    output          Rin, //next stage req
    input           Rout //before stage req
    );


    genvar i;
    generate
    for(i=0; i<dlynum; i=i+1) begin: dly_buf
        wire buf_in, buf_out; 
        if(i==0) begin
            assign #1 buf_in = Rout;
        end else if(i==(dlynum-1)) begin
            assign Rin = buf_out;
            assign #1 buf_in = dly_buf[i-1].buf_out;
        end else begin
            assign #1 buf_in = dly_buf[i-1].buf_out;
        end

        //BUFFD0BWP7T30P140HVT i_buf (buf_in, buf_out);
    end
    endgenerate

endmodule

