Subject: MPC855T, SCC1 as UART hangs
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 16 Jun 2003 17:17:56 +0200
Message-ID: <30C145E544071F4FB8B627789F7910BD328FF1@csy-exchange1.giat.intra>
From: "ARIBAUD Albert" <A.ARIBAUD@giat-industries.fr>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a MPC855T-based board with SMC1, SMC2 and SCC1 configured as UARTs (ttyS0 to 2).
I also use SPI and I2C, and the FEC.
The kernel is 2.4.4 from the ELDK; I tried the CVS linux_2.4 also.

My problem is:

When I boot the board with the 2.4.4 kernel and the ELDK pRamdisk,
I can cat /etc/protocols >/dev/ttyS2 alright; but if I boot using the same kernel but with an NFS-mounted root, then the same cat hangs until I ctrl-C it.

Since the kernel is exactly the same in both cases, I thought I'd find something in /etc that would play tricks on ttyS2 during bootup, but I found none.

Does anyone here use SCC1 as an UART on an MPC8xx, or have experienced similar problems trying?

Thanks in advance,

Albert.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
