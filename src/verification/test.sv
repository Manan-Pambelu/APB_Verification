class test;
	virtual APB_if.DRIVER drv_vif;
	virtual APB_if.MONITOR mon_vif;
	virtual APB_if.REFERENCE ref_vif;

	environment env;

	function new( virtual APB_if.DRIVER drv_vif,virtual APB_if.MONITOR mon_vif, virtual APB_if.REFERENCE ref_vif);
			this.drv_vif=drv_vif;
			this.mon_vif=mon_vif;
			this.ref_vif=ref_vif;
	endfunction

	task run();
		env=new(drv_vif, mon_vif, ref_vif);
		env.build();
		env.start();
	endtask

endclass

