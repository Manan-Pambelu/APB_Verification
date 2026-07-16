class environment;

	virtual APB_if.DRIVER dr_vif;
	virtual APB_if.MONITOR mon_vif;
	virtual APB_if.REFERENCE ref_vif;

	mailbox #(transaction) gd_mbx;
	mailbox #(transaction) dr_mbx;
	mailbox #(transaction) ms_mbx;
        mailbox #(transaction) rs_mbx;

	generator   gen;
	driver      drv;
	monitor     mon;
	scoreboard  scb;
	//reference   reff;

	function new(virtual APB_if.DRIVER dr_vif, virtual APB_if.MONITOR mon_vif, virtual APB_if.REFERENCE ref_vif);
		this.dr_vif=dr_vif;
		this.mon_vif=mon_vif;
		this.ref_vif=ref_vif;
	endfunction

	task build();
		begin
			gd_mbx=new();
			dr_mbx=new();
			ms_mbx=new();
			rs_mbx=new();

			gen =new(gd_mbx);
			drv=new(gd_mbx,dr_mbx,dr_vif);
			mon=new(ms_mbx,mon_vif);
			//reff=new();
			//scb=new(ms_mbx,rs_mbx);

		end
	endtask

	task start();
		fork
		gen.start();
		drv.start();
		mon.start();
		//scb.start();
		//reff.start();
		join

		//scb.summary();
	endtask
endclass


			


