Message-Id: <200102070217.UAA09357@lists.linuxppc.org>
Subject: psurge quad droping to xmon with pauluas and bk 2_4 trees
Date: Tue, 6 Feb 2001 21:16:31 -0800
From: Mark Guertin <mguertin@macdiscussion.com>
To: "linuxppc-dev list" <linuxppc-dev@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all

With the latest paulus 2.4.0 tree and linuxppc_2_4 my Daystar quad
(psurge machine) drops to xmon at bootup.  It goes through the initial
bootup texts and drops to xmon right before it would normally kick over
to the 4 penguins... info as follows

<snip>
smp_psruge_kick_cpu
smp_psruge_kick_cpu - done
found cpu 3
smp_commence

cpu 0: vector: 0 at pc = c0035494, lr = c0035494, msr = 9032, sp =
c04cfdd0 [c04cfd18]
current = c04ce000, pid = 1, comm = swapper
0:mon>


from System.map

c0035414 t smp_call_function_all_cpus




This happens with both new kernels (smp.c is identical in both kernels
ATM).  If anyting else is need I would be glad to help.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
