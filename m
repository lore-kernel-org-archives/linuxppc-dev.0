Date: Tue, 6 Jun 2000 22:05:58 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michel Dänzer <daenzerm@student.ethz.ch>
cc: "David L. Thompson" <dthompsn@vizsolutions.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree86-4.0 Status?
In-Reply-To: <3938C6EC.40FFE599@student.ethz.ch>
Message-ID: <Pine.LNX.4.10.10006062201100.1984-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > I was wondering if anybody could comment on the status of
> > XFree86-4.0. I tried installing this on a PowerBook G3/250 and have
> > had no luck. I've seen just a few posts in regards to "support isn't
> > there yet" so I was wondering if anybody could comment.
>
> I suppose that's Mach64 hardware, so you have to use the fbdev driver _and_ a
> patched kernel to correct broken OF PCI memory mappings.
>
> Ask Michael Schmitz :)

I haven't tried it on that machine but if it's a Mach64 chipset there will
likely be a PCI resource collision between VRAM and MMIO space. I had to
patch both 2.3.99pre7 and 2.2.15 to make it work. For 2.3.x, Geert's old
PCI resource patch did fine, reassignment for 2.2.15 is a bad hack likely
to break on other machines (I just guessed a free PCI address range
instead of walking the resource tree).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
