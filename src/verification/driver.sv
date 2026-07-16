`include "define.svh"

class driver;

	transaction trans_obj;
	mailbox #(transaction) gd_mbx;
	mailbox #(transaction) dr_mbx;

	virtual APB_if.DRIVER vif;
/*
	covergroup drv_cg;
		read_data : coverpoint trans_obj.PRDATA { bins prdata[]={[0:255]};}
		ready     : coverpoint trans_obj.PREADY { bins pready[]={0,1};}
		slv_error : coverpoint trans_obj.PSLVERR { bins pslverr[]={0,1};}

		M_transfer: coverpoint trans_obj.transfer { bins transfer[]={0,1};}
		wr_rd     : coverpoint trans_obj.write_read { bins wr_rd[]={0,1};}
		addr_in   : coverpoint trans_obj.addr_in {bins addr_in[]={[0:255]};}
		wdata_in  : coverpoint trans_obj.w_data_in {bins wdatain[]={[0:255]};}
		strobe    : coverpoint trans_obj.strb_in {bins strobe[]={0,1};}
	endgroup
*/
	function new(mailbox #(transaction) gd_mbx,mailbox #(transaction) dr_mbx, virtual APB_if.DRIVER vif);
		this.gd_mbx=gd_mbx;
		this.dr_mbx=dr_mbx;
		this.vif=vif;
		//drv_cg=new();
	endfunction


	task start();
		repeat(2) @(vif.driver_cb);
		for(int i=1; i<=`transaction_count; i++)
		begin

			$display("/////////////////////////////////////////////////////////////////////////////////////////////////////////");
			
				//trans_obj=new();
                                gd_mbx.get(trans_obj);
				$display("%m driver driving at iteration %d",i,$time);

                     if(vif.driver_cb.PRESETn==0)

			 

			begin
				@(vif.driver_cb)
				
				vif.driver_cb.PRDATA     <=0;
				vif.driver_cb.PREADY     <=0;
				vif.driver_cb.PSLVERR    <=0;	
			        vif.driver_cb.transfer   <=0;
				vif.driver_cb.write_read <=trans_obj.write_read;
				vif.driver_cb.addr_in    <=0;
				vif.driver_cb.wdata_in  <=0;
				vif.driver_cb.strb_in    <=0;

                                 
				dr_mbx.put(trans_obj);

				//drv_cg.sample();
				//$display("COVERAGE WHEN PRESETn IS 0 --------> %d",drv_cg.get_coverage());

			end
		else
		begin
			
			@(vif.driver_cb)

			vif.driver_cb.PRDATA     <=trans_obj.PRDATA;
			vif.driver_cb.PREADY     <=trans_obj.PREADY;
			vif.driver_cb.PSLVERR    <=trans_obj.PSLVERR;

			vif.driver_cb.transfer   <=trans_obj.transfer;
			vif.driver_cb.write_read <=trans_obj.write_read;
			vif.driver_cb.addr_in    <=trans_obj.addr_in;
			vif.driver_cb.wdata_in  <=trans_obj.wdata_in;
			vif.driver_cb.strb_in    <=trans_obj.strb_in;

			dr_mbx.put(trans_obj);

			//drv_cg.sample();
			//$display("COVERAGE WHEN PRESETn IS 1 --------> %d",drv_cg.get_coverage());

		end
                begin
		$display("***************Driver sending**********************");
		$display("PRDATA %h",trans_obj.PRDATA);
		$display("PREADY %d",trans_obj.PREADY);
		$display("PSLVERR %d",trans_obj.PSLVERR);
		$display("transfer %d",trans_obj.transfer);
		$display("write_read %d",trans_obj.write_read);
		$display("addr_in %h",trans_obj.addr_in);
		$display("w_data_in %h",trans_obj.wdata_in);
		$display("strb_in %b",trans_obj.strb_in);
                $display("***************************************************");

		           

		$display("Interface transfer=%0d addr=%h",vif.driver_cb.transfer, vif.driver_cb.addr_in); // just to check whether driver sending through vif
		end
		end

		endtask

		

endclass
				



