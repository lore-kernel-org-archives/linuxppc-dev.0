Date: Wed, 14 Mar 2001 14:53:58 -0800
From: andrew may <acmay@mace.penguinpowered.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: Frank Rowand <frank_rowand@mvista.com>
Subject: Walnut 405GP and a 3com 905
Message-ID: <20010314145358.B5558@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Anyone try to use a 3com NIC card on the Walnut board?

I can load the module but when I try to bring up the
interface I get a stream of bus errors.

eth1: using NWAY autonegotiation
eth1: Host error, FIFO diagnostic register 0000.
eth1: PCI bus error, bus status 80000020
eth1: using NWAY autonegotiation
eth1: Host error, FIFO diagnostic register 0000.
eth1: PCI bus error, bus status 80000020
eth1: using NWAY autonegotiation
eth1: Host error, FIFO diagnostic register 0000.

I am using the 2.4.2 version of the Walnut kernel dated
Mar 1 on the ftp site.

There are changes to the 3com driver in the pre patches
but I have not tried it yet.

Most docs say this is a hardware failure so I might want
to change the PCI slot I am using.

Has anyone successfully used a PCI network card in the
Walnut board.

If it is just a driver bug I do not want to spend time
fixing it, I would just want to get a card that works.

I just want to do some perf testing on board itself.

Thanks

--
Andrew May


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
