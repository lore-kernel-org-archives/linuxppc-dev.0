Message-ID: <B1DF47D78E82D511832C00B0D021B520083DE6@SAKTHI>
From: Srinivasa Rao V <veeru@ctd.hcltech.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Tundra PowerSpan initialization
Date: Mon, 13 Aug 2001 15:14:19 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

My board is MPC8260 based board and I had been trying to initialize the
Tundra PowerSpan Registers.
Single PCI PowerSpan contains a lot of Registers like the
	PCI-1 Register Image Base Address Register
	PCI-1 Target Image X Base Address Registers
	PCI-1 Target Image X Translation Address Registers

	Processor Bus Slave Image X Translation Address Registers
	Processor Bus Slave Image X Base Address Registers.

The PowerSpan manual does not give full details of what each corresponds to.
I am confused as to what address ranges to be entered for what.
I tried various sets of address ranges in which one looks like
				PB_SI0_TADDR = 0x00000000; PB_SI0_BADDR =
0x40000000;
			          	P1_BST0 = 0x00000000 size 32MB;
P1_BST1 = 0xFF000000 size 16MB; ...
When I try to access the PCI location 0x40000000 the system hangs.

If anyone has any idea on this, please help me out.

Thanks in advance,
Srini

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
