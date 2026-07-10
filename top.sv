module APB_top();
	import package::*;
		
logic PCLK;
logic PRESET;

initial 
	PCLK=1'b0;
	forever #5 PCLK=~PCLK;
initial begin
	repeat(4)
		@(posedge PCLK)
		PRESET=0;
	repeat(200)
		@(posedge PCLK)
		PRESET=1;
end

APB_if intrf(PCLK,PRESET); 
	
apb_master DUV_apb_master( .transfer(intrf.transfer),.write_read(intrf.write_read),.addr_in(intrf.addr_in),.wdata_in(intrf.wdata_in),.strb_in(intrf.strb_in),.rdata_out(intrf.rdata_out), .transfer_done(intrf.transfer_done), .error(intrf.error),.PADDR(intrf.PADDR), .PSEL(intrf.PSEL), .PENABLE(intrf.PENABLE), .PWRITE(intrf.PWRITE), .PWDATA(intrf.PWDATA), .PSTRB(intrf.PSTRB), .PRDATA(intrf.PRDATA), .PREADY(intrf.PREADY), .PSLVERR(intrf.PSLVERR)); 

	initial begin 
		test test1;
		test_1 = new(intrf.DRIVER, intrf.MONITOR, intrf.REFERENCE ); 
		test_1.run(); 
		$finish;
	end 
endmodule 


