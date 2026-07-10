class reference;
	mailbox #(transaction) dr_mbx;
	mailbox #(transaction) rs_mbx;
	virtual APB_if.REFERENCE vif;

	transaction trans_obj;

	function new( mailbox #(transaction) dr_mbx,mailbox #(transaction) rs_mbx,virtual APB_if.REFERENCE vif);
		this.dr_mbx=dr_mbx;
		this.rs_mbx=rs_mbx;
		this.vif=vif;
	endfunction

	for(int i=0; i<=`transaction_count; i++)
endclass


