Date: Mon, 2 Oct 2000 22:52:07 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch: PCI resource fixup for atyfb (was: Re: xf 4.0.1 + ati
 driver with rage II/rage pro)
In-Reply-To: <19340827142007.16524@192.168.1.10>
Message-ID: <Pine.LNX.4.10.10010022249530.21133-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >I'm trying to get a handle on using both LCD and external monitor in
> >Linux, that's why I started playing with it.
>
> You have to choices. Either enable both outputs on the same CRTC (works
> with old "LG" chips found in some wallstreet's), or program both CRTCs

Works automagically if I plug in the external after booting. If I have the
external monitor plugged in at boot, the LCD is disabled on boot. But you
probably knew that.

> (Rage LT Pro only). In the later case, you can use a different setup for
> the LCD, do real dual-head, have a higher refresh rate for the CRT, etc....

Fine, but how would I do that? And how do I tell atyfb to set up two
framebuffers for the two separate screens`?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
