`timescale 1ns/1ps

module MullC (
    output  reg     Out, 
    input           Ain,
    input           Bin,
    input           Rst
    );


always @(*) begin
    if(Rst)
        Out = 0;
    else if(Ain == Bin)
        Out = Ain;
end

endmodule
