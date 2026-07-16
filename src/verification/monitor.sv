`include "define.svh"

class monitor;
	transaction trans_obj;
	mailbox #(transaction) ms_mbx;
	virtual APB_if.MONITOR vif;

	function new(mailbox #(transaction)ms_mbx, virtual APB_if.MONITOR vif);
		this.ms_mbx=ms_mbx;
		this.vif=vif;
		//coverage pending
	endfunction

	task start();
		repeat(1)
		@(vif.monitor_cb);
		for(int i=0; i<=`transaction_count; i++)
		begin
			@(vif.monitor_cb)
			trans_obj=new();
			begin
				trans_obj.PADDR=vif.monitor_cb.PADDR;
				trans_obj.PSEL=vif.monitor_cb.PSEL;
				trans_obj.PENABLE=vif.monitor_cb.PENABLE;
				trans_obj.PWRITE=vif.monitor_cb.PWRITE;
				trans_obj.PWDATA=vif.monitor_cb.PWDATA;
				trans_obj.PSTRB=vif.monitor_cb.PSTRB;
			end
			$display("MONITOR TO SCOREBOARD PADDR is %h | PSEL is %d | PENABLE is %d | PWRITE is %h | PWDATA is %h | PSTRB is %b \n\n ",trans_obj.PADDR,trans_obj.PSEL,trans_obj.PENABLE,trans_obj.PWRITE, trans_obj.PWDATA, trans_obj.PSTRB);


			$display("monitor vif PENABLE %d   PWDATA %h transfer %d",vif.monitor_cb.PENABLE ,vif.monitor_cb.PWDATA, vif.monitor_cb.transfer);

			ms_mbx.put(trans_obj);
			//sample for coverage pending
		end
	endtask
endclass




