Content-Type: text/plain;
  charset="us-ascii"
From: "S. Hebbar" <shebbar@india.tejasnetworks.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: JFFS2 problem when data cache enabled
Date: Fri, 30 Apr 2004 13:50:20 +0530
Cc: shebbar@india.tejasnetworks.com
MIME-Version: 1.0
Message-Id: <200404301350.20513.shebbar@india.tejasnetworks.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am experiencing JFFS2 FS problem when I enable data cache on 8260 based
custom board.  (266/166/66 MHz).

While the node is booting up, I get the following error on the console.
I am using linuxppc-2.4.20-denx. with latest patches for JFFS2 and MTD.

The board has 8MB of AMD AM29LV641 chipset.

When I disable the datachache on linux kernel, everything works fine.

Any help on debugging this problem is very much appreciated.

Thanks,
Hebbar.

=====================
Freeing unused kernel memory: 52k init
Mounting /dev/mtdblock3 on /etc as jffs2 file system.
init started:  BusyBox v0.60.5 (2004.03.04-09:24+0000)
multi-call<5>jffs2_get_in
ode_nodes(): Data CRC failed on node at 0x00011b90: Read 0x0000053f,
calculated
0xd06df7c8
floating point used in kernel (task=c759c000, pc=c0395a20)
Machine check in kernel mode.
Caused by (from SRR1=4b030): Transfer error ack signal
Oops: machine check, sig: 7
NIP: C0395A28 XER: 00000000 LR: C0395A20 SP: C759DB60 REGS: c759dab0 TRAP:
0200
   Not tainted
================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
