class scoreboard;
	transaction trans_mon, trans_ref;
	mailbox #(transaction) ms_mbx;
	mailbox #(transaction) rs_mbx;

	int MATCH, MISS;

	function new(mailbox #(transaction) ms_mbx,mailbox #(transaction) rs_mbx);
		this.ms_mbx=ms_mbx;
		this.rs_mbx=rs_mbx;
         endfunction

	 task start();
		 for(int i=0; i<=transaction_count; i++)
		 begin
			 trans_mon=new();
			 trans_ref=new();

			 fork
				 begin
					 rs_mbx.get(trans_ref);
					 $display("%m------------------------SCORBOARD REFERENCE--------------------------");
					 $display("PADDR = %h ",trans_ref.PADDR);
					 $display("PSEL = %d ",trans_ref.PSEL);
					 $display("PENABLE =  %d ", trans_ref.PENABLE);
					 $display("PWRITE = %d ",tras_ref.PWRITE);
					 $display("PWDATA = %h ",trans_ref.PWDATA);
					 $display("PSTRB = %b ",trans_ref.PSTRB);
					 $display("rdata_out = %h ",trans_ref.rdata_out);
					 $display("transfer_done = %d ",trans_ref.transfer_done);
					 $display("error = %d ",trans_ref.error);
					 $display("------------------------------------------------------------------------");

				 end
				 begin
					 ms_mbx.get(trans_mon);
					 $display("%m------------------------SCORBOARD MONITOR--------------------------");
					 $display("PADDR = %h ",trans_mon.PADDR);
					 $display("PSEL = %d ",trans_mon.PSEL);
					 $display("PENABLE =  %d ", trans_mon.PENABLE);
					 $display("PWRITE = %d ",tras_mon.PWRITE);
					 $display("PWDATA = %h ",trans_mon.PWDATA);
					 $display("PSTRB = %b ",trans_mon.PSTRB);
					 $display("rdata_out = %h ",trans_mon.rdata_out);
					 $display("transfer_done = %d ",trans_mon.transfer_done);
					 $display("error = %d ",trans_mon.error);
					 $display("------------------------------------------------------------------------");
				 end
			 join

			 compare();
	 endtask

	 task compare();
	if((trans_ref.PADDR== trans_mon.PADDR)	&&(trans_ref.PSEL== trans_mon.PSEL)&&(trans_ref.PENABLE	== trans_mon.PENABLE)	
 	&&(trans_ref.PWRITE == trans_mon.PWRITE) &&(trans_ref.PWDATA  == trans_mon.PWDATA)   &&	(trans_ref.PSTRB == trans_mon.PSTRB)
    	&&(trans_ref.rdata_out == trans_mon.rdata_out)  &&(trans_ref.transfer_done == trans_mon.transfer_done) &&(trans_ref.error    == trans_mon.error))
        
	MATCH++;
	$display("============================================DATA MATCH SUCCESSFUL MATCH=%d================================================",MATCH);
	
	else
	MISS++;

	$display("============================================DATA MATCH UNSUCCESSFUL MISS=%d================================================",MISS);
	end
endtask


task summary();
begin
	$display("////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////");
	$display("//////////////TOTAL MATCH =%d ////////////////////////////////////TOTAL MISS =%d ///////////////////////////////////////////////////");
	$display("////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////");
end
endtask
endclass

				


