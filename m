Message-ID: <002d01c0c8e8$2c7532e0$a001a8c0@zamolxe>
From: "Simbotelecan Serban" <sserban@optsol.ro>
To: <ppcboot-users@lists.sourceforge.net>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: MPC8240 used as busmaster
Date: Thu, 19 Apr 2001 18:48:20 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I am currently developing the firmware for a PCI board with a MPC8240
processor. The MPC8240 will be used to transfer memory blocks between PCI
board and a PC host. We want to use the MPC8240 as a host and to transfer
memory blocks between MPC's local memory and PC's memory using MPC's DMA. I
tried to make some DMA transfers from MPC's local memory to PCI, but nothing
happened (from local to local it worked).
I didn't find anywhere sample code or a guide line about how to use MPC8240
as busmaster in a system where another host exists (which can be an Intel,
AMD, VIA or other chipset). Any help, code, suggestions, will be welcome.

Thanks in advance
Simbotelecan Serban


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
