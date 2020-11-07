module ahb_mux
import ahb_params_pkg::*;
#(DATA_WIDTH=32, NUM_SLAVE=3);
    (
        input [DATA_WIDTH-1:0] HRDATA_i [NUM_SLAVE],
        input HREADYOUT_i [NUM_SLAVE],
        input HRESP_i [NUM_SLAVE],
        input HSEL[NUM_SLAVE],
        output reg [DATA_WIDTH-1:0] HRDATA,
        output reg HRESP,
        output HREADY
    );

    always @(*)
    begin
        if(HREADYOUT_i[0] || HREADYOUT_i[1] || HREADYOUT_i[2])
        begin
            //when none of HSEL[0], [1], [2] are valid, default slave is [0]
            HRDATA = HSEL[0] ? HRDATA_i[0] : (HSEL[1] ? HRDATA_i[1]: (HSEL[2] ? HRDATA_i[2]: HRDATA_i[0]));
            HRESP = HSEL[0] ? HRESP_i[0]: (HSEL[1] ? HRESP_i[1]: (HSEL[2] ? HRESP_i[2]: HRESP_i[0]));
            HREADY = HSEL[0] ? HREADYOUT_i[0] : (HSEL[1] ? HREADYOUT_i[1]: (HSEL[2] ? HREADYOUT_i[2]: HREADYOUT_i[0]));
        end

    end

endmodule
