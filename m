Date: Wed, 23 Aug 2000 15:50:26 +0200 (CEST)
From: Ronald Wahl <rwa@peppercon.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: allocating uncachable memory
Message-ID: <Pine.LNX.4.21.0008231540530.12497-100000@goliath.issistance.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm writing a driver for a PCI controller in a PPC system. That driver
"exports" a bit of local ram into the PCI space. Now if some PCI device is
writing into this memory the local system won't notice it in all cases
since this memory is cached. How can i allocate uncached memory in linux?
Or if this does not work how can I remap it as non-cachable. I already
tried ioremap_nocache but this does not work for real memory. It would be
nice if someone could give me a short code fragment...

thanx,
ron


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
