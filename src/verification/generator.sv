`include "define.svh"

class generator;
	transaction trans_obj;
	mailbox #(transaction) gd_mbx;

	function new(mailbox #(transaction) gd_mbx);
		trans_obj=new();
		this.gd_mbx=gd_mbx;
	endfunction

	task start();
		for(int i=0; i<=`transaction_count; i++)
		begin
			assert(trans_obj.randomize());
			gd_mbx.put(trans_obj.copy());
		        
			$display("generator generated %d no of transaction transfer %d, write_read %d, addr_in %h, wdata_in %h, strb_in %b, PRDATA %h, PREADY %d, PSLVERR %d",i,trans_obj.transfer,trans_obj.write_read,trans_obj.addr_in,trans_obj.wdata_in,trans_obj.strb_in,trans_obj.PRDATA,trans_obj.PREADY,trans_obj.PSLVERR);
	end
	endtask
endclass



