Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1D579DDE24
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Mar 2008 18:35:40 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Jb9sd-0002iD-MV
	for linuxppc-embedded@ozlabs.org; Mon, 17 Mar 2008 00:35:35 -0700
Message-ID: <16089631.post@talk.nabble.com>
Date: Mon, 17 Mar 2008 00:35:35 -0700 (PDT)
From: Qin Lin <linkinge@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: XUPV2P board opb_emac cannot work with linux-2.6-xlnx
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


HI all,

Is anyone have the opb_emac (no DMA) work with the kernel linux-2.6-xlnx
from git.xilinx.com.
the message seams that it does work ,but the command ping return nothing!

Could you kindly suggest me what to do?

ps:
the kernel booting message
[    0.258674] net_namespace: 64 bytes
[    0.269780] NET: Registered protocol family 16
[    0.290415] Registering device xilinx_emac:0
[    0.381687] NET: Registered protocol family 2
[    0.392324] IP route cache hash table entries: 2048 (order: 1, 8192
bytes)
[    0.399556] TCP established hash table entries: 8192 (order: 4, 65536
bytes)
[    0.403403] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[    0.405409] TCP: Hash tables configured (established 8192 bind 8192)
[    0.405489] TCP reno registered
[    0.412758] sysctl table check failed: /kernel/l2cr .1.31 Missing
strategy
[    0.413189] Call Trace:
[    0.413244] [cf41feb0] [c0008178] show_stack+0x48/0x184 (unreliable)
[    0.413467] [cf41fed0] [c00303c8] set_fail+0x50/0x68
[    0.413640] [cf41fef0] [c0030b54] sysctl_check_table+0x64c/0x698
[    0.413724] [cf41ff20] [c0030b68] sysctl_check_table+0x660/0x698
[    0.413802] [cf41ff50] [c001e810] register_sysctl_table+0x64/0xb4
[    0.414141] [cf41ff70] [c01e4b1c] register_ppc_htab_sysctl+0x18/0x2c
[    0.414311] [cf41ff80] [c01de1e4] kernel_init+0xc8/0x284
[    0.414384] [cf41fff0] [c0004ab8] kernel_thread+0x44/0x60

[    1.116395] xilinx_emac xilinx_emac.0: MAC address is now  2: 0: 0: 0: 0:
0
[    1.123790] XEmac: using fifo mode.
[    1.128188] XEmac: Detected PHY at address 0, ManufID 0x0013, Rev.
0x78e2.
[    1.135715] eth0: Dropping NETIF_F_SG since no checksum feature.
[    1.151038] eth0: Xilinx 10/100 EMAC at 0x40C00000 mapped to 0xD0020000,
irq=2
[    1.158713] eth0: XEmac id 1.4a, block id 128, type 1
[    1.194661] TCP cubic registered
[    1.198647] NET: Registered protocol family 1
[    1.203728] NET: Registered protocol family 17
 

#ping 192.168.26.1 & 
# ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 02:00:00:00:00:00
          inet addr:192.168.26.127  Bcast:192.168.26.255  Mask:255.255.255.0
          UP BROADCAST RUNNING  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:16 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:672 (672.0 B)
          Interrupt:2 Memory:40c00000-40c0ffff

Regards

Qin Lin
-- 
View this message in context: http://www.nabble.com/XUPV2P-board-opb_emac-cannot-work-with-linux-2.6-xlnx-tp16089631p16089631.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
