module PipeAdder_tb();
reg rst;
reg [7:0] a,b,c;
reg Rin;
reg Aout;

wire Rout;
wire Ain;
wire [7:0] out;

PipeAdder u0_PipeAdder(
    .rst(rst),
    .a(a),
    .b(b),
    .c(c),

    .Rin(Rin),
    .Aout(Aout),//ack
    .Rout(Rout),//req
    .Ain(Ain),
    .out(out)
);

integer  i,j,k;
initial begin
rst = 0 ;
#10 rst = 1;
#5  rst = 0;
Rin = 1;
Aout = 1;

    for(i=0;i<5;i=i+1)begin
        for(j=0;j<5;j=j+1)begin
            for(k=0;k<5;k=k+1)begin
                #20 a = i;
                b = j;
                c = k;
            end
        end
    end 

#1000 $finish;
end

initial begin
        $dumpfile("wave.vcd"); // 指定用作dumpfile的文件
		$dumpvars; // dump all vars
end

endmodule