module finta_tic (
    input wire clk,              // The 250MHz Disciplined Clock
    input wire rst_n,            // Active Low Reset
    input wire gps_1pps,         // The asynchronous GPS pulse
    output reg [31:0] meas_data, // The measurement (Sent to CPU)
    output reg meas_valid        // Toggles when new data is ready
);

    reg [31:0] counter;
    reg [2:0] pps_sync; // Synchronizer for the external signal

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 0;
            meas_data <= 0;
            pps_sync <= 0;
            meas_valid <= 0;
        end else begin
            // 1. Synchronize the GPS signal to our 250MHz clock domain
            // This prevents metastability since GPS is external
            pps_sync <= {pps_sync[1:0], gps_1pps};

            // 2. Rising Edge Detection (0 -> 1 transition on synchronized signal)
            if (pps_sync[2:1] == 2'b01) begin
                // SNAPSHOT: Loop A Sensor Reading
                // Ideally, this value is 250,000,000. 
                // If > 250M, clock is fast. If < 250M, clock is slow.
                meas_data <= counter;
                meas_valid <= ~meas_valid; // Signal CPU that data updated
                
                // Reset counter for the next second
                counter <= 0;
            end else begin
                counter <= counter + 1;
            end
        end
    end
endmodule