Date: Tue, 27 Jun 2000 14:46:06 -0400 (EDT)
From: Michael Coy <mac12@po.cwru.edu>
To: linuxppc-embedded@lists.linuxppc.org
Subject: PCMCIA ATA flash support -- correction
Message-ID: <Pine.GSO.4.10.10006271441450.1929-100000@amazon>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Correction: C0002D7C is in fact ide_init_hwif_ports.
This makes much more sense.

But it still doesn't explain what could cause that piece of kernel code to
be zeroed out.  Any suggestions would be greatly appreciated.

Sorry for the confusion,
mike


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
