From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15044.444.777880.743127@pizda.ninka.net>
Date: Thu, 29 Mar 2001 19:47:08 -0800 (PST)
To: Daniel Berlin <dan@www.cgsoftware.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ieee1394 fixed soon...
In-Reply-To: <Pine.LNX.4.10.10103290950010.11075-100000@www.cgsoftware.com>
References: <15042.57778.640138.923390@pizda.ninka.net>
	<Pine.LNX.4.10.10103290950010.11075-100000@www.cgsoftware.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Daniel Berlin writes:
 > As sopon as the the ieee1394 maintainer gets on the ball, i'll submit
 > them again.

If they continue to be unresponsive, I can ask Linus what we
as maintainers should do.

 > > 	p->value &= cpu_to_le32(0xfffffff0);
 > >
 > > works _PERFECTLY_ fine.

 > Not for me

This is mathmatically impossible.  :-)  Something else has to account
for it.

Maybe, you were hitting a compiler bug or similar, but you were not
hitting a problem because the logic is wrong.

 > I'm pretty sure, however, that I did that change
 > individually, and it made a difference.

Please verify this now, and check for miscompilation if you still
see the problem.

 > > I know what needs to be swapped thats why I did the patches I did :-)
 >
 > It's trickier than you may think, because motherboard implementations of
 > firewire aren't required to honor the byte swapping setting, making it
 > pretty useless.

I've read this paragraph of the OHCI specification.  Find me a
motherboard controller found on a big-endian system which does
not implement this bit, then I will begin to be concerned.

 > sure, as soon as they start actually maintaining ieee1394.

Why don't we contact them and give them a week, explaining that if
they don't wish to be active in ieee1394 driver maintainence then you
and I are willing to help more actively co-maintain the ieee1394 layer
together. :-)

Later,
David S. Miller
davem@redhat.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
