`include "define.svh"

interface APB_if(input logic PCLK, input logic PRESETn);

	//outputs of slave inputs to the master
	logic [`DATA_WIDTH-1:0] PRDATA;
	logic  PREADY;
	logic  PSLVERR;

	//inputs to the master from user
	logic transfer;
	logic write_read;
	logic [`ADDR_WIDTH-1:0] addr_in;
	logic [`DATA_WIDTH-1:0] wdata_in;
	logic [(`DATA_WIDTH/8)-1:0] strb_in;


	//output of master inputs to the slave
	logic [`ADDR_WIDTH-1:0] PADDR;
	logic PSEL;
	logic PENABLE;
	logic PWRITE;
	logic [`DATA_WIDTH-1:0] PWDATA;
	logic [(`DATA_WIDTH/8)-1:0] PSTRB;

	//output from master to the user
	logic [`DATA_WIDTH-1:0] rdata_out;
	logic transfer_done;
	logic error;

	clocking driver_cb @(posedge PCLK);
		default input #0 output #0;

		output PRDATA, PREADY, PSLVERR;
		output transfer, write_read, addr_in, wdata_in, strb_in;
		input PRESETn;
	endclocking


	clocking monitor_cb @(posedge PCLK);
		default input #0 output #0;

		input PADDR, PSEL, PENABLE, PWRITE, PWDATA, PSTRB;
		input rdata_out, transfer_done, error;
		input transfer;
	endclocking

	clocking reference_cb @(posedge PCLK);
		default input #0 output #0;
	endclocking

	
	modport DRIVER(clocking driver_cb);
	modport MONITOR(clocking monitor_cb);
	modport REFERENCE(clocking reference_cb);

endinterface



	 


