Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <200403111144.i2BBiOM4015518@ms.usish.com>
From: "Jack Liu" <Jack_liu@usish.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>,
	"m.venkatraj@exgate.tek.com" <m.venkatraj@exgate.tek.com>
Subject: Re: problems with NFS root for ADS860
Mime-Version: 1.0
Content-Type: text/plain
Date: Thu, 11 Mar 2004 19:43:15 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all
    Currently I am porting linux to a new MPC8241 board. I am using
Motorola sandpoint porting code as a reference. So I modified
ppc/platforms/Sandpoint*.* file to adapt to the new board. I just
replace these four files(I am using 2.4.21 ppc kernel).
    Also, I am using MPC8241's UART.So I also changed setup_io_mappings
function to
	"io_block_mapping(0xfc000000, 0xfc000000, 0x02000000, _PAGE_IO); "

   Do I still need to make other changes? In my understanding , porting
linux in ppc platform is register the following files.
	ppc_md.setup_arch = sandpoint_setup_arch;
	ppc_md.show_cpuinfo = sandpoint_show_cpuinfo;
	ppc_md.irq_cannonicalize = sandpoint_irq_cannonicalize;
	ppc_md.init_IRQ = sandpoint_init_IRQ;
	ppc_md.get_irq = sandpoint_get_irq;
	ppc_md.init = sandpoint_init2;

	ppc_md.restart = sandpoint_restart;
	ppc_md.power_off = sandpoint_power_off;
	ppc_md.halt = sandpoint_halt;
	ppc_md.time_init = NULL;
	ppc_md.set_rtc_time = NULL;
	ppc_md.get_rtc_time = NULL;
	ppc_md.calibrate_decr = todc_calibrate_decr;

	ppc_md.find_end_of_memory = sandpoint_find_end_of_memory;
	ppc_md.setup_io_mappings = sandpoint_map_io;

  	Am I correct on this?  Please help me on this.

Best regards
Jack

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
