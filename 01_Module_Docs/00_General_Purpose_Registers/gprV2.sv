// Synchronous writes and asynchronous reads

module gpr(
    input logic        clk,
    input logic        rstn_h,
    input logic [4:0]  rs1n,
    input logic [4:0]  rs2n,
    input logic [4:0]  rdn,
    input logic [31:0] rdd,
    input logic        wbe,

    output logic [31:0] rs1d,
    output logic [31:0] rs2d
);
    logic [31:0] registers [31:0];

    always(@(posedge clk or negedge rstn_h)) begin
        if (!rstn_h) begin
            for(int i = 0; i < 32; i++) begin
                registers[i] <= 32'b0;
            end
        end
        else begin
            registers[0] <= 32'b0;

            if (wbe && (rdn != 5'b0)) begin
                registers[rdn] <= rdd;
            end 
        end
    end

    assign rs1d = (!rstn_h) ? 32'b0 : registers[rs1n];
    assign rs2d = (!rstn_h) ? 32'b0 : registers[rs2n];

endmodule
