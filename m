Message-ID: <3C7505C7.DBF3ED6D@imc-berlin.de>
Date: Thu, 21 Feb 2002 15:35:51 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>,
	PPC <ppcboot-users@lists.sourceforge.net>
Subject: MPC8xx FEC, MII, Hubs and Switches ?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I got my custom board with a MPC855T up and running.
FEC is working fine. MII/MDIO interrupts are working.

If I disconnect my board from the hub, I get

eth0: status: link down

When I plug it back in, I get

eth0: status: link up, 10Mbps Half Duplex, auto-negotiation complete.

BUT when I plug it into a 10/100 Fast Ethernet Switch (namly D-LINK DES
10160) the link  does _not_ come up again!

This also means that I can't boot linux via bootp/tftp.

Any idea? Anyone?

Thanks in million!

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
