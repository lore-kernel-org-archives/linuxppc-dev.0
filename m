To: "'linuxppc-embedded@lists.linuxppc.org'"
    <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3A718D21.66F9227D@lucent.com>
Date: Fri, 26 Jan 2001 08:43:45 -0600
From: Tom Roberts <tjroberts@lucent.com>
MIME-Version: 1.0
Subject: Query: PCI and Ethernet hardware/drivers
References: <B25E2E5A003CD311B61E00902778AF2A0148B69D@server1.skystream.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We are in the throes of designing some new hardware, and have several
questions. We will probably not start porting Linux to the board until
May or June, and hope that Linux 2.4/PPC will be stable by then. This
will be an SMP MPC7410 board with lots of SDRAM. (we have existing
non-SMP boards to work with initially, and we have a "toy" port of
Linux 2.2.15 to one of them)

1) Does Linux/PPC handle the PCI bus properly?

2) Are there Linux/PPC drivers for the PLX 9054 (PCI interface) chip?
   (Yes, that is PPC 60x-bus, not MAX bus; the hardware will handle that)

3) What Ethernet MAC chips have people had success using?
   (right now we favor an AMD chip, which they claim has Linux drivers,
   but their test plan includes only AMD and Intel CPUs, not PowerPC)

4) We favor a 4-CPU SMP configuration. What not-so-obvious problems
   are we likely to face? (e.g. our simulations show that doing this
   at 133 MHz cannot be done using a CPLD-based memory controller:
   wimpy data-bus drivers (:-() Our existing boards are all non-SMP,
   and bus snooping is a bit of a mystery to us....


	[While some people may not consider a 4-SMP 7410 board with
	 4 GB of SDRAM to be "embedded", we certainly do. But it is a
	 BIG step up from an 860....]


Any comments or suggestions you have will be appreciated.


Tom Roberts	tjroberts@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
