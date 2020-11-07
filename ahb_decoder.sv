module ahb_decoder
import ahb_params_pkg::*;
#(NUM_SLAVE=3, ADDR_WIDTH=32, K_BOUNDARY=1) //K_BOUNDARY = 1,2,3...

    (
        input [ADDR_WIDTH-1:0] HADDR,
        input HREADY,
        output reg HSEL[NUM_SLAVE] // supporting 3 slaves as of now & will be connected to mux
    );

    always @(*)
    begin
        if(HADDR >= 'h0 && HADDR <= 2**(10*K_BOUNDARY)-1) //Slave 1
        begin
            HSEL[0] = 'b1;
            HSEL[1] = 'b0;
            HSEL[2] = 'b0;
        end
        else if(HADDR >= 2**(10*K_BOUNDARY) && HADDR <= 2**(2*10*K_BOUNDARY)-1) //Slave 2
        begin
            HSEL[0] = 'b0;
            HSEL[1] = 'b1;
            HSEL[2] = 'b0;
        end
        else if(HADDR >= 2**(2*10*K_BOUNDARY) && HADDR <= 2**(3*10*K_BOUNDARY)-1) //Slave 3
        begin
            HSEL[0] = 'b0;
            HSEL[1] = 'b0;
            HSEL[2] = 'b1;
        end
        else
        begin
            HSEL[0] = 'b1;
            HSEL[1] = 'b0;
            HSEL[2] = 'b0;
        end
    end

endmodule
