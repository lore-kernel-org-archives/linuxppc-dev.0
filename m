Date: Mon, 25 Sep 2000 14:42:49 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: R Shapiro <rshapiro@bbn.com>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display!
In-Reply-To: <14799.14699.552209.136967@esb.bbn.com>
Message-ID: <Pine.LNX.4.10.10009251439380.31592-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  > Anything about PCI problems in the server log?
>
> The only server log I have right now is for the X I left running
> yesterday with the fbdev driver.  There are a couple of PCI warnings
> in this one but no errors (no surprise, since everything is working
> well with fbdev):
>
> (**) (null)(2): claimed PCI slot 0:15:0
> (II) FBDev(2): using /dev/fb2
> (WW) ****INVALID IO ALLOCATION**** b: 0x400 e: 0x4ff correcting
> (II) window:
>         [0] -1  0x00000000 - 0x0000ffff (0x10000) IXB
> (II) resSize:
> (II) window fixed:
>         [0] -1  0x00000000 - 0x0000ffff (0x10000) IXB
> (WW) ****INVALID IO ALLOCATION**** b: 0x400 e: 0x4ff correcting
>

These shouldn't be critical (but they shouldn't happen, either).

>  > BTW: Can you use yaboot for booting?
>
> I don't know, can I use yaboot on a rev. a beige G3?  I think the

Probably not - it could work with the b&w one, that's why I asked.

> Are there known X-related problems using BootX?

You were looking at it, from what I guess. Apple's drivers set up
overlapping areas for MMIO and VRAM, and X fixes this by disabling one of
these. Unfortunatly, the kernel doesn't notice.

>  > > 4. On the rev. b beige G3 w/Mach64 Rage Pro, the ati driver seems to
>  > > be working.  The XF probe still gets the wrong amount of vram, and it
>  > > still throws away the mode I constructed via fbset -x.  But it finds
>  >
>  > Perhaps the video RAM detection typo which should be gone now ...
>
> Fwiw I'm using the ati driver I built from sources rsync'd on
> Saturday.

That should have the stupid typo removed ...

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
