Message-ID: <002101c20736$bb52f640$7c99883e@m5axc>
Reply-To: "Neil Wilson" <nwilson@airspan.com>
From: "Neil Wilson" <nwilson@airspan.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: pci_consistent_alloc & mpc107 snoop
Date: Wed, 29 May 2002 18:31:43 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I hope someone can enlighten me .....

Am I right in thinking that pci_consistent_alloc gets me
uncached memory ?, if not is there an easy way to modify the pages allocated
?

The reason being is that we have an mpc7450/mpc107 board with a custom
pci ethernet card (it runs a modified pcnet32 driver) and also a soft
ethernet
port in an fpga.  The hardware designer reckons we are getting stung with a
motorola 7450 errata (#46 if anyone is interested), where the 7450 can hang
during signalling retries with the 107.

Our hardware designer therefore wants the pci ethernet to use uncached
buffers &
also to have the 107 pci snoop disabled.  I have disabled snoop in the boot
code (ppcboot) and the ethernet card still works, but now it does not work
under Linux (it used to be fine with snoop enabled, nfs etc all worked).

Any ideas ....?

Thanks.

Neil


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
