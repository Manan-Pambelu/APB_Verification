`include "define.svh"
class transaction;

         rand bit transfer;
         rand bit write_read;
         rand bit[`ADDR_WIDTH-1:0] addr_in;
         rand bit[`DATA_WIDTH-1:0] wdata_in;
         rand bit[(`DATA_WIDTH/8)-1:0] strb_in;

         rand bit[`DATA_WIDTH-1:0]PRDATA;
         rand bit PREADY;
         rand bit PSLVERR;

         //output from the master
         bit[`DATA_WIDTH-1:0] rdata_out;
         bit transfer_done;
         bit error;
	 bit [`ADDR_WIDTH-1:0]PADDR;
	 bit PSEL;
	 bit PENABLE;
	 bit PWRITE;
	 bit [`DATA_WIDTH-1:0]PWDATA;
	 bit [(`DATA_WIDTH/8)-1:0]PSTRB;

	constraint c1 { PSLVERR==0;}
	constraint c2 { write_read==1;}


        virtual function transaction copy();
                copy=new();
                copy.transfer=this.transfer;
                copy.write_read=this.write_read;
                copy.addr_in=this.addr_in;
                copy.wdata_in=this.wdata_in;
                copy.strb_in=this.strb_in;
                copy.PRDATA=this.PRDATA;
                copy.PREADY=this.PREADY;
                copy.PSLVERR=this.PSLVERR;

 		return copy;
        endfunction

endclass
