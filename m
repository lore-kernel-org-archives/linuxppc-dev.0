Message-Id: <200403230445.i2N4j7kZ030569@ms.usish.com>
From: "Jack Liu" <Jack_liu@usish.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: OpenPIC problem:OpenPIC not work at 0xFC000000 on MPC8245 platform
Mime-Version: 1.0
Content-Type: text/plain
Date: Tue, 23 Mar 2004 12:44:12 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,all
  I encounted a problem when I assign EUMB to 0xFC000000 not
0xFDF00000. When EUMB at 0xFDF00000, it OpenPIC works ok. However
when I change it to 0xFC000000, EPIC seems not work. I am not sure
this is related to MAPB options. Because the following comments in
ppc/kernel/mpc10x_common.c:

/*
	 * Want processor accesses of 0xFDxxxxxx to be mapped
	 * to PCI memory space at 0x00000000.  Do not want
	 * host bridge to respond to PCI memory accesses of
	 * 0xFDxxxxxx.  Do not want host bridge to respond
	 * to PCI memory addresses 0xFD000000-0xFDFFFFFF;
	 * want processor accesses from 0x000A0000-0x000BFFFF
	 * to be forwarded to system memory.
	 *
	 * Only valid if not in agent mode and using MAP B.
	 */
  What does "Want processor accesses of 0xFDxxxxxx to be mapped to PCI
memory space at 0x00000000." mean? Does this 0xFDxxxxxx have anything to
do with EUMB?

  Can anybody give me your vaulable advice?
Best regards
Jack Liu

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
