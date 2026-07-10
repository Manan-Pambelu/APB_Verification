interface APB_if(PCLK, PRESET);

	//outputs of slave inputs to the master
	bit [`DATA_WIDTH-1:0] PRDATA;
	bit PREADY;
	bit PSLVERR;

	//inputs to the master from user
	bit transfer;
	bit write_read;
	bit [`ADDR_WIDTH-1:0] addr_in;
	bit [`DATA_WIDTH-1:0] w_data_in;
	bit [(`DATA_WIDTH/8)-1:0] strb_in;


	//output of master inputs to the slave
	bit [`ADDR_WIDTH-1:0] PADDR;
	bit PSEL;
	bit PENABLE;
	bit PWRITE;
	bit [`DATA_WIDTH-1:0] PWDATA;
	bit [(`DATA_WIDTH/8)-1:0] PSTRB;

	//output from master to the user
	bit [`DATA_WIDTH-1:0] rdata_out;
	bit transfer_done;
	bit error;

	clocking driver_cb @(posedge PCLK);
		default input #0 output #0;

		output PRDATA, PREADY, PSLVERR;
		output transfer, write_read, addr_in, w_data_in, strb_in;
		input PRESET;
	endclocking


	clocking monitor_cb @(posedge PCLK);
		default input #0 output #0;

		input PADDR, PSEL, PENABLE, PWRITE, PWDATA, PSTRB;
		input rdata_out, transfer_done, error;
	endclocking

	clocking reference_cb @(posedge PCLK);
		default input #0 output #0;
	endclocking

	
	modport DRIVER(clocking driver_cb);
	modport MONITOR(clocking monitor_cb);
	modport REFERENCE(clocking reference_cb);

endinterface



	 


