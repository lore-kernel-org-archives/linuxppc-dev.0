Message-ID: <3810FB75.87486F32@netx4.com>
Date: Fri, 22 Oct 1999 20:04:05 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Linux on CLLF: Don't ask, I'll tell
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I decided to post this before I forget.

This information is only important if you want to use the
10/100 Ethernet on the Embedded Planet RPX-CLLF (or Classic).

Well, here is something that is important in any case.  The
CLLF is "just" a Classic without the PCI and a smaller form
factor.  To build a kernel for the CLLF, just select RPXC (or
RPX-Classic) and don't select the PCI configuration.  There
is no menu selection for the CLLF.

I don't have the Ethernet PHY completed for this board.  So, we
need help from the boot ROM monitor to initialize it.  At the
main menu, select 'O' for On-board I/O tests.  At the next
menu, select '9' for the 100 Mbit Ethernet.  At the next menu,
select '0' (that's zero) to toggle between 10 and 100 so it
matches your network.  Now, at this point I also downloaded
the kernel, so I don't know if you need to actually perform
some I/O at this point.  Make sure you hit enough ESCs to
get back to the main menu....

When the kernel boots, ignore the FEC messages about link
status.  It is looking at registers and bits that are not
appropriate for the PHY on this board.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
