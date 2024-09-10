module FSM_COUNT(
    input logic start , clk ,reset ,
    output logic F , [3:0] units, tens
);

always_ff @(posedge clk or posedge reset)
    begin 
        if (reset)
        begin
            units <= 4'b0000;       // Reset counter to 0
            tens <= 4'b0000;       
            F <= 0;               // Reset F
        end 
        else 
            begin if (start)
                begin
                    if (units >= 4'b1001) 
                        begin
                            units <= 4'b0000;  // Reset count1 to 0 after reaching 9
                                if (tens <= 4'b0101)  tens++;
                                if (tens > 4'b0101) tens = 4'b0000;
                        end 
                    else units++;
                    if (tens == 4'b0101) F=1;
                    else  F=0; 
                end
            end
    end
endmodule