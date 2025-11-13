// Synchronous writes and asynchronous reads

module gpr #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 5)(
    input logic                    clk,
    input logic                    rstn_h,
    input logic [ADDR_WIDTH - 1:0] rs1n,
    input logic [ADDR_WIDTH - 1:0] rs2n,
    input logic [ADDR_WIDTH - 1:0] rdn,
    input logic [DATA_WIDTH - 1:0] rdd,
    input logic                    wbe,

    output logic [DATA_WIDTH - 1:0] rs1d,
    output logic [DATA_WIDTH - 1:0] rs2d
);
    logic [DATA_WIDTH - 1:0] registers [31:0];

    always(@(posedge clk or negedge rstn_h)) begin
        if (!rstn_h) begin
            for(int i = 0; i < 32; i++) begin
                registers[i] <= 'b0;
            end
        end
        else begin
            registers[0] <= 'b0;

            if (wbe && (rdn != 'b0)) begin
                registers[rdn] <= rdd;
            end 
        end
    end

    assign rs1d = (!rstn_h) ? 'b0 : registers[rs1n];
    assign rs2d = (!rstn_h) ? 'b0 : registers[rs2n];

endmodule
