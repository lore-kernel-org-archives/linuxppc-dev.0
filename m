Subject: MPC8266 Linux kernel hang on idma_pci9_read()
From: Jeff Angielski <jeff@theptrgroup.com>
To: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1067285723.4137.26.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 27 Oct 2003 15:15:23 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I am trying to track down a problem where the Linux kernel is hanging
when it is trying to configure the IDE interface on a CMD648 PCI-to_IDE
CPCI card.  The kernel correctly detects the cards on the bus and
configures them.  However, it's hanging in the call to idma_pci9_read()
when trying to read the simplex_stat from the first byte from the first
PCI I/O region on the card (say that ten times fast).

The MPC8266 board is a custom board based on the MPC8266ADS harware and
LSP.  The Linux kernel is 2.4.23-pre2 from penguinppc.

I was just wondering if anybody else had seen anything similiar on their
MPC8266ADS-based designs.

TIA,
Jeff Angielski
The PTR Group


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
